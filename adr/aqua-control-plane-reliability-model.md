# Aqua Control plane reliability model

References:

- [Calculating composite SLA](https://alexewerlof.medium.com/calculating-composite-sla-d855eaf2c655)
- [Uptime calculator](https://uptime.is/)
- [Finastra cluster network diagram](https://docs.fusionoperate.io/docs/diagram-resources/operatingPlatform/FFDC-network-Prod-LK02.drawio.png)
- [Fortigate Azure admin guide](https://docs.fortinet.com/document/fortigate-public-cloud/7.0.0/azure-administration-guide/983245/ha-for-fortigate-vm-on-azure)
- [Azure SLAs](https://azure.microsoft.com/en-us/support/legal/sla/summary/)
- [Azure SLA for Virtual Machines](https://azure.microsoft.com/en-us/support/legal/sla/virtual-machines/v1_9/)
- [Aqua SaaS End User License Agreement](https://www.aquasec.com/eula-saas/) (Schedule A ~ Service Level Agreement)

## Cluster outbound connections involved components

Based on the Finastra cluster network diagram, the outbound connection path is cluster -> Fortigate FW -> internet.

### Fortigate FW

We'd have 2 VMs in an availability set behind an Azure Load balancer (standard SKU) running Fortigate.

| Component                    | Availability |
| ---------------------------- | ------------ |
| Azure availability set       | 99.95%       |
| Azure standard load balancer | 99.99%       |
| Total for Fortigate          | 99.94%       |

### Finastra firewall botched changes

Let's consider 1 day (24h) lost every 6 months caused by connectivity issues due to firewall untested or botched changes.

| Component          | Availability |
| ------------------ | ------------ |
| Finastra firewalls | 99.45%       |

## Aqua SaaS control plane

Aqua SaaS control plane SLA for "Service Hours" is 99.9%.
However, this does not account for:

- Scheduled Maintenance Interruption
- Anything outside of the direct control of Company (including downtime resulting directly or indirectly from **any failures of Company’s third party hosting providers**)
- Force majeure events

Jesse Miller requested to provide more usable actual uptime numbers. Aqua legal team has been engaged for guidance on this question, and answered:

> We are unable to grant SLA terms which are not consistent with Aqua’s [standard terms](https://www.aquasec.com/support-terms/) as provided uniformly to all of our customers. The SLA provided in those terms is the only SLA relating to Aqua’s SaaS platform.

## Global control plane availability

Does not take Aqua scheduled maintenance interruptions and Aqua 3rd party hosting provider downtime.

| Component          | Availability |
| ------------------ | ------------ |
| Fortigate          | 99.94%       |
| Finastra firewalls | 99.45%       |
| Aqua control plane | 99.9%        |
| Total              | 99,29%       |

This means:

- Daily: 10m 13s
- Weekly: 1h 11m 34s
- Monthly: 5h 8m 38s
- Yearly: 2d 13h 43m 34s

## Failure modes

### Enforcers cannot connect to the control plane

#### Enforcer Behavior

- Enforcers keep applying the policies they know about.
- Enforcers don't get policy updates which would be made in the control plane as long as the connectivity is broken.
- Enforcers pull policy updates from the control plane when the connectivity is restored.
- A new enforcer started while the connectivity is broken is most probably unable to apply anything until it can pull the policies.

#### Operational Impact

- Enforce of existing policies on already running node: the event will not be propagated to the control plane. Current security alerting & incident response process is triggered by control plane event triggers (defined in "response policy").
  _Supplemental control:_ log monitoring for such events. Implmentation note: how to handle dups?
- New enforcers will not be able to load config and register with control plane. What is the impact to nodepool scaleout? For windows hosts (vmss extension) and linux hosts (daemonset). Will the enforcers log error, and retry, not blocking node readiness, or will it block node readiness?

_Action Items_

- Enforcer failure mode tests (measure impact to security event process and impact to node readiness)
  - JIRA: simulate no connectivity for enforcer-to-console; scale out Windows node pool
  - JIRA: simulate no connectivity for enforcer-to-console; scale out Linux node pool
- Designs for addressing results from those tests

Basic question is: does the outage only impact our threat detection and response capability, or is there also an availability consequence?

In case of blocking node readiness

- existing sessions will work
- new sessions for active tenants with available capacity on active nodes will be creatable
- no new tenants can be onboarded
- no new user sessions for active tenants if they require new capacity

#### Potential Solutions

1. Accept risk of loss of security controls during outage, in favor of preserving availability. Avoid enforcer failure preventing node readiness, implement retry. Design required. Depict other controls in place (e.g. WAF)
2. Do not accept risk of loss of security controls during outage. Compare probability of outage to LaserPro SLOs.
   Planned frequency of scale actions: pre-Hyper-V, weekly activity. Post-Hyper-V, daily or hourly

### Build agents cannot connect to the control plane

- A build agent without connectivity to the control plane is not able to successfully perform a scan.
- This would break builds on the master branch, and may or may not break other builds depending on user settings (would not break, by default).

#### Potential workarounds

Our plan to switch to scan enforcement at deploy time only using OPA/Gatekeeper will solve for failed builds due to control plane connectivity issues. Only a warning would then be raised in build pipelines. Such un-scanned builds could still be deployed on lower environments, but not on higher ones where OPA/Gatekeeper would block them.
