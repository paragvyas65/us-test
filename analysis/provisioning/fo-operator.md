# Relationship to Terraform

Fusion Operate Operator is used to manage resources for the platform in response to management of domain model interaction (modeled as Kubernetes CRDs: hence, "Operator")

Global product definitions are managed in finastra-platform/fo-product-management repo, using "product" tf module.

```
product-management
|-- products
|     ffdc.tf
|     malauzai.tf
```

1. Terraform is used to manage product definition globally.
1. FO Operator CRDs are used for control and data zone deployments.
1. TFCO workspace is used by FO operator to provision out of cluster infra attached to zone resources, and k8s lifecycle.

# Operator Design

## Goals

### "FO Cloud Operator"

Given an FO Zone cluster
And FO Env and Domain CRDs registered in that cluster
When an FO Env, Domain CRs are deployed to that zone cluster
Then the corresponding namespace, edge-local, edge-global, resource groups are provisioned

### Bootstrapping

1. Zone env module installed via TF
2. ACM Agent registration for cluster
3. FO Cloud Operator is deployed
4. FO CRs are applied via ACM

## "FO Cloud Operator" functionality

- Map from CR to HelmRelease (those depicted in [platform_apps](../platform_apps.md))
- labeling admission controller (e.g. to apply ns labels to pods)
- domain labeling to distinguish between public ingress required or not (relevance to edge-local ingress enablement);
  edge: local|global|none
  mesh: europe-mesh (which consists of mesh zones per FO Zone and VM-based product env)

## Scenarios

1. Attach a VM-based environment to the Zone (e.g. to support hybrid apps like GPP) (should not be the first scenario)
   "external/hybrid env" CR deployed; side-effect: PrivateLink, firewall rules, NetworkPolicies provisioned that connect the internal namespace to VM network

2. User Experience for product managing domains, envs, zone-bindings compared to the CRD creation and assignment to the correct Placement Rule

```yaml
product:
  name: ffdc

domains:
  api-ctl:
    apps:
      devportal: ...
      org-mgmt:
  api-data:
    apps:
      gateway-mgmt:

env:
  name: dev
  domains: api-ctl, api-data
```

```yaml
product:
    name: malauzai

domains:
    sami:
      apps:
        sami;
        adapter-websterfi
    cms:
      apps:
        :

envs:
 - name: dev
   domains:  sami
   name: uat05
   domain: sami, cms, blah

```

## Next Steps

- Workshops to flesh out design, scenarios, and diagrams
- Identify expertise needed; gaps in skills and in automation
- Technology stack selection and framework (will provide an example for other FO Operators)
- What is the strategy for constraining technical debt during current provisioning efforts?
- Identify potential other FO Operators, and their interaction/dependencies

# Service Mesh, Zones

Review solution architecture from Kong (Bill Decoste)
Consider design for hybrid env with Mesh instead of PrivateLink (compare features and costs)
Design mesh+zone partitioned for FO Zones, Products, Envs,
