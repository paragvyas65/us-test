## Option 1: align with product provisioning schema

Pros

- is clear for product
- names are what they choose
- maps to FO domain

```yaml
environments:
  - name: dev
    zones:
      - eastus_dev1
  - name: perf
    zones:
      - eastus_perf
  - name: preprod
    zones:
      - eastus_preprod
      - westus_preprod
  - name: prod
    zones:
      - eastus_prod
      - westus_prod
```

## Option 2:

Generic for promotion and interaction betweeen flux and k8s

- Implication
  - no use of env or zone field names
- Pros
  - will allow for open source of implementation
  - decoupled from envs and zones (in case these need to diverge in future)
- Cons
  - more for product to understand
  - What names to use?

# Naming

## Names, not IDs

- Azure Resource Name: pplac060043040201050a001
  Platform generated - using naming api, per azure resource naming conventions

- FO Zone Name: platform-engineering-westus[-02]
  Platform generated - using Zone naming convention,
  Controled by tenant-mgmt "product.yaml" processing,
  used as input to Zone module

- westus_preprod: Product name for zone (alias that is meaningful to them)

### TODO

sequence diagram for name progression and discovery

```
  Product Alias -> product.yaml
    -> FO Zone Name -> git://zone-apps (/promotion.yaml|values/)
    -> FO Zone Name -> git://zone-infra (/config)
```

## Target Schema

### Decision: Option 1

Constraints

- promotion file is maintained exclusively by the Zone module
- promotion flow is configured by the product in the product-onboarding yaml in tenant-management.
- Must support concurrent upgrades of cluster and app for speed of rollout (sequential is too slow - quantify?)

e.g. in git://laserpro-zone-apps

```yaml
promotion:
  - name: dev
    zones:
      - alias: eastus_dev1
        name: platform-engineering-eastus-02
        priority: 0
  - name: perf
    zones:
      - alias: eastus_perf
        name: platform-engineering-eastus-02
        priority: 0
  - name: preprod
    zones:
      - alias: eastus_preprod
        name: platform-customer-eastus-02
        priority: 0
      - alias: westus_preprod
        name: platform-customer-westus-02
        priority: 1
  - name: prod
    zones:
      - alias: eastus_prod
        name: platform-customer-eastus-02
        priority: 0
      - alias: westus_prod
        name: platform-customer-westus-02
        priority: 1
```

## Product Experience

1. zone-infra/promotion.yaml is maintained by the Zone module
2. zone-apps/promotion.yaml is maintained by the Zone module
3. Product exclusively interacts with the tenant-mgmt/product.yaml for defining zones, envs, bindings and sequencing
4.

## Implementation Notes

Can we decouple zone name -> flux folder mapping?
What constraints on the promotion pipeline?

## Managing Multiple Logical Environments per Zone

TODO: Vladimir to walk through proposal of repo structure for managing this case. Problem: haven't solved yet for managing the case where some of the "logical environment apps" would not be deployed to some of the zones in the case of "one promotion flow per gitops repo" constraint. (perhaps an exclude feature?)

Example

```
environments:
- name: dev
  zones:
  - eastus_dev1
- name: perf
  zones:
  - eastus_perf
- name: preprod
  zones:
  - eastus_prod
  - westus_prod
- name: prod
  zones:
  - eastus_prod
  - westus_prod
```
