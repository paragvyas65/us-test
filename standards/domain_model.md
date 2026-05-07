# Domain Model

Versions in this document.
| Version | Description |
| ------- | ----------- |
| v1 | Fusion Operate prior to the ARO rollout and CESS integration/usage. This is largely FO as organically adopted from FusionFabric.cloud |
| v2 | Fusion Operate incorporating CESS domain model and expanding formally to support the ARO rollout and on-boarding of teams and usage patterns beyond the original FFDC-centric cases |
| v3 | Fusion Operate operating as a converged DevOps Platform for Finastra cloud-native delivery and operations, part of a single platform story (link here). |

Note: after the Fusion Operate APIs are published, and product management changes to align features to well-defined quarterly, PI-aligned releases and feature roadmap, these versions will go away. The versioning scheme expected then will be like Kubernetes resource versioning.

## Product

@since v2

A tenant of Fusion Operate. Product is the unit of segmentation for

- access control
- cost attribution
- cost management

### Personas

| Persona       | Goals                                                           | Examples |
| ------------- | --------------------------------------------------------------- | -------- |
| Product Owner | Manage group membership, define budgets, allocate quota, manage |

<table>
  <tr>
    <td>Persona</td>
    <td>Goals</td>
    <td>Examples</td>
  </tr>
  <tr>
    <td>Product Owner</td>
    <td>
      <ul>
        <li>Manage group membership</li>
        <li>Define budgets</li>
        <li>Allocate quota</li>
        <li>Manage on-call rotation</li>
      </ul>
    </td>
    <td>
      <ul>
        <li>Essence PO adds a user to the Essence-developers AAD group during team on-boarding, so that the engineer has access to Essence repos and envs.</li>
        <li>LenderComm PO sets a alert to notify the LenderComm operator team (non-prod group) when kubernetes compute spend surpasses $1,000 CAD per week.</li>
        <li>FusionFabric.cloud requests sets a larger quota for the api-data-plane domain in each pre-prod zone.</li>
        <li>P2Go adds an FO team member to P2Go-opd-prod group during an incident response to assist in remediation.</li>
      </ul>
    </td>
  </tr>
</table>

## Team

@version v3

Unit of access control and delegation. Team is introduced in FO version 2 to allow for group management at a finer level of control than products had previously.

- Products can define teams, which are materialized as AAD groups
- Product owners can define team owners to delegate membership control
- Traditional FO product-level groups that have pre-defined permission sets per FO resource, become Roles, which can be assigned to Teams

Products define domains, teams, and logical environments.

## Domain

@version v2

Subdomain of a product. Each product defines subdomains that group applications so that those applications can have specilized access to each other. E.g. some reasons to group apps in a subdomain are

- to share some config
- they need to be colocated with each other in specific regions for data residency or proximity reasons
- so they can communicate "directly" with each other without going through our API platform

To domains are bound applications, teams and logical environments.

## Application

@version v1

Unit of value, unit of lifecycle. Since Fusion Operate is Kubernetes-centric, an application is a helm chart: a versioned set of kubernetes resources with a well-defined deployment lifecycle. An application deployment is a helm release in a given cluster.

## Deployment Environment

@version v2

What we think of as an actual environment--an isolated set of compute, networking, resources for apps to be deployed into and consume. This is a Kubernetes namespace in an FO Zone, with the associated cloud resource group, Tf Cloud workspace, KeyVault or akeyless path, backing PaaS services for the applications in that deployment environment.

A deployment environment

- can host one or many applications
- must belong to one and only one domain
- must belong to one and only one logical environment
- is a unique deployment target for an application pipeline
- can be created directly, e.g. for a temporary namespace

## Logical Environment

@version v2

A logical grouping of deployment environments. e.g. dev, perf, uat, pre-prod, prod, pci, non-pci. When a logical environment is bound to a Zone, ingress and egress resources are provisioned. For instance, this allows for deployments environments belonging to the same logical environment to share the same ingress or egress network proxies, such as

- temporary deployment environments sharing the same "ffdc-dev" ingress proxy. In this case those deployment environments belong to the "dev" logical environment of the "ffdc" product.
- customer-specific deployment environments sharing the same ingress proxy and operating team. E.g. essence-prod-customer1 and essence-prod-customer2

## Zone

@version v2

An FO Zone is a multi-tenant hosting envelope for application deployment environments. It means an FO Kubernetes cluster environment, and all of the adjacent, attached cloud resources

Future versions of FO Zones might be dedicated per tenant. E.g. a Zone exclusively for LaserProCloud, or for P2Go Managed Services.

## Customer

@version v3

Customer does not exist yet. Need to introduce for billing, audit and reporting for ServiceNow integration, and FFDC domain alignment. e.g. for customer-specific deployment environments.

isolation for apps (net, compute)

- env
  - domain(s) belonging to deployment env
- service (???)

# Platform Domain Mapping

The below mappings are intended to

1. Facilitate a common understanding when using Finastra platforms
2. Help our platform implementors understand expected integrations
3. Most importantly - continue convergence efforts to a common platform domain model.

With this understanding, not all of the mappings are exact. Where necessary, additional clarification should be provided.

| Fusion Operate | FusionFabric.cloud | ServiceNow          | CESS       |
| -------------- | ------------------ | ------------------- | ---------- |
| Product        | na                 | BusinessApplication | Product    |
| Team           | Organization       | na                  | na         |
| Domain         |                    |                     | Role (ish) |
| Application    | Application        |                     |            |

# Implementation Notes

## Kubernetes Namespace Naming

The kubernetes namespace is the same as the name of the deployment environment name, and is to be generated by the FO domain APIs.

### Constraints

Kubernetes namespaces must

- Contain at most 63 characters
- Contain only lowercase alphanumeric characters or `-`
- Start with an alphanumeric character
- End with an alphanumeric character

### Convention

Format:

```
ns name:  <productId>-<domain>-<deploymentEnv>
deploymentEnv name: <logicalEnv>-<deploymentEnv>

If the deployment environment name is "default", it will by default be excluded from the name.  It is the default deployment environment, so it's superfluous to add it to the logical env.  A product could chose to have it included once the API supports that flag on the DE resource.

# TODO switch to BNF
```

### Examples

1. Kafka environment for Essence (customer-specific)
   - P: essence, D: kafka, LE: prod, DE: prod-tinkoff
   - ms: essence(pid)-kafka-prod-tinkoff
2. Kafka environment for P2Go (multi-tenant)
   - P: p2go, D: kafka, LE: prod, DE: prod-shared
   - ns: p2go(pid)-kafka-prod-shared
3. Fusion Operate container-platform, base zone provisioning
   - P: FO-CP, D: zone, LE: dataplane (e.g. to distinguish from ctl-plane), DE: default
   - ns: focp(pid)-zone-dataplane
   - Note: this is a case of the default DE name being excluded
4. FusionFabric.cloud dev portal pre-prod
   - P: FFDC, D: apictl, LE: preprod, DE: default
   - ns: ffdc(pid)-apictl-preprod
5. FusionFabric.cloud dev portal feature branch acceptance temp env
   - P: FFDC, D: apictl, LE dev, DE: tmp-PRUUID (could alternatively be tmp logical env)
   - ns: ffdc(pid)-apictl-dev-tmp-PRUUID
