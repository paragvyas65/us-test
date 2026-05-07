# CESS Product Prerequisites

Instructions are at https://finastra.stackenterprise.co/questions/307 (SO-307). Perform manual provisioning pre-requisites listed as steps 1-6 in SO-307.

1. Create new role ids for product ID at https://portal.provides.io/ The following items are required and note role ids created:

| Resource                                              | Notes                                                                                                                                                 | Implementation                                                                                                                                                                                                                 |
| ----------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| new CESS product                                      | bold statement: make product resource mgmt part of this provisioning                                                                                  | v1 is assert product exists only (not in dataproxy provider). Can descope and make prereq                                                                                                                                      |
| SP to create roles in CESS API                        | SP in AAD, with read-write privileges to "CESS API scopes"                                                                                            | v1 - global scoped SP for this FO-owned repo+workspace; provisioned elsewhere (1-off)                                                                                                                                          |
| Role: Microsoft.KeyVault/vaults                       | {product} FO Keyvault; platform-managed secrets, such "service binding" cases                                                                         | dataproxy provider resource                                                                                                                                                                                                    |
| Role: Microsoft.ContainerRegistry/registries          | {product} ACR                                                                                                                                         | dataproxy provider resource                                                                                                                                                                                                    |
| Role: Provides.ServicePrincipal/DevOps/ResourceGroup  | {product} Azure DevOps SP - used later for AzDO access to KVs and ACRs, via AzDO service connections                                                  | dataproxy provider                                                                                                                                                                                                             |
| Role: Microsoft.KeyVault/vaults                       | {product} Project Keyvault; for product self-service secrets mgmt                                                                                     | dataproxy provider                                                                                                                                                                                                             |
| AAD Security Group: SG_AZR-FO-{product}-RnD           | product "developer" group; output names and ObjectIDs needed for subsequent steps                                                                     | GAP: aad_security_group module (start with github module)                                                                                                                                                                      |
| AAD Security Group: SG_AZR-FO-{product}-Ops           | product "operator" group; output names and OIDs needed for subsequent steps                                                                           | GAP: aad_security_group module                                                                                                                                                                                                 |
| AAD Security Group Membership: SG_AZR-FO-Umbrella-RnD | Add the product-RnD/Ops groups to this umbrella group                                                                                                 | GAP: aad_security_group module                                                                                                                                                                                                 |
| AppConfig entries                                     | AAD Group names and ObjectIds stored in Platform AppConfig p21d24304513001; analysis required ([FO-13623](https://jira.finastra.com/browse/FO-13623)) | v1: preserve current mgmt of appconfig, having tf manage keys; azurerm provider supports, but we don't have module (GAP: module for appconfig keymgmt) v2: evaluate not using appconfig, using the names and IDs from TF state |
| SP: SP-CESS-161-DEV-{product}                         | service principal for interacting with CESS API, secrets stored in subscription-specific FO KV: p21d24304508001                                       | cess v1 provider (GAP: writing outputs to KV, managing permission to write to these KVs); consider different secrets mgmt                                                                                                      |
| SP: SP-CESS-161-QA-{product}                          | service principal for interacting with CESS API, secrets stored in subscription-specific FO KV: p01q24302508001                                       | same as above                                                                                                                                                                                                                  |
| SP: SP-CESS-161-UAT-{product}                         | service principal for interacting with CESS API, secrets stored in subscription-specific FO KV: p21u24301508001                                       | same as above                                                                                                                                                                                                                  |
| SP: SP-CESS-161-PROD-{product}                        | service principal for interacting with CESS API, secrets stored in subscription-specific FO KV: p01p24301508001                                       | same as above                                                                                                                                                                                                                  |
| Input Defect Dojo pid                                 | should be part of "product definition"                                                                                                                | v1. Tools interaction is manual pre-req, but relevant IDs, project names, etc will be on the Product definition                                                                                                                |

### Notes

Reconsider how FO subscription-level service principals are managed: secrets provisioning and expiry notification

#### Current Implementation

```
# For each subscription-specific KV

CESS team will create like this:
SP-CESS-161-DEV-{product}-client-id
SP-CESS-161-DEV-{product}-client-secret

create new secrets with those values in this format
CessClientId{product}
CessClientSecret{product}
```

How are these keys used, by which automation? Is per-sub, per-product credentials stored in per-sub KVs still the right model for "FO v1" zones? Should this change for FO v2 model? Must be included in ([FO-13623](https://jira.finastra.com/browse/FO-13623)).

# CESS Event

_Status_: Not Started; Need identified, likely to just incorporate into FO onboarding improvements

### Context

1. With FO 1.0, CESS product provisioning, role-id provisioning, other (?) are separate, manual events
1. They don't have to be manual, and should be integrated into the fo-onboarding automatiom
1. These CESS interactions should be managed in TF-based FO onboarding as soon as possible

### Product provisioning in CESS API High-level actions

Adhoc request that culminates in product resource existing in CESS API. Side effects

- Finance informed of product and has mapping from PID to "something meaningful in SNow"
- product assigned CMDB mappings
- Acceptance: cloudability reporting works based on product tag (for "free")
- Not yet doing handoff to product owner for cloudability usage (reporting, setting up budgets and monitoring)

### TODO

- capture this process on the docs site, and integrate into the provisioning automation
