# GitOps Promotion Pipeline

## Decisions

1. Central "release" repostiory doesn't work for the entire zone-set because of: (iter. 1)
   1. UX - too many open PRs will be open against one repository
   1. Potential merge conflicts
1. We support centralised promotion.yaml in the root of the repo and promotion.yaml per application (iter. 1)
1. We support one promotion scope per repo: either per-repo or per-app aka no overrides (iter. 1)
1. Logical environment applications (Helm charts) managed with a help of GitOps PP from a git repo (iter. 1)
1. Parent chart describes logical environment by refereincing individual apps (charts) (iter. 2)
1. FO Operator manages defintion of a logical environment based on CR resources (iter. 3)
1. Enforce promotion lifecycle for logical environment apps. Example: `edge-local` application can be deployed to uppper environment only after successful deployment to all lower ones.
1. Reasons for having separate.
1. V2 of STIZ will have clearly defined logical environment definition: either a CR or a Helm chart
1. For the first three tenants (LPro, FFDC, P2Go) we accept manual management of promotions.yaml and zone specific value overrides for zonal and environment applciations. See backlog item for this to be resolved past first three tenants.
1. Ability to set automerge for raised PRs to `release` branch

## Considerations

1. Ability to have multiple re-usable `promotion.yaml` files:
   1. multiple files in the repo root
   1. reference to remote promotion.yaml

## Backlog Items

- Develop self-discovery mechanism for zonal applications which should provide zone specific configuration to the applications, ie: zone specific domain name for ingress resource. (iter 2)
- Research auto-approve for PRs to release branch based on Codeowners configuration (iter 1)
- How to report/surface status of deployment back to GitHub (iter 1)
- POC gitops connector (iter 1)
- POC smee.io (iter 1)
- Comparison to today's implementation, for backlog review
- Vet the git repo operations for usage in TF GitOps (goal: process and change mgmt consistency)
- Backlog creation, with priorities on answering any lingering questions

<!-- ## TODO

1. What are the pros/cons and differences for/between option #1 or option #2 for environment apps repos
    1. Single app that promotes all zone-environment bindings
        1. Pros
            1. Promotion across all environments and zones
        1. Cons
    1. App per environment that promotes across zones within the env
        1. Pros
        1. Cons
    1. How experience changes?
    1. How to know where particular app is in the promotion lifecycle. -->

## Scenarios

### 1. Need to deploy multiple logical envs to a single zone

Example: `eastus_prod` zone can host `preprod` and `prod` logical environments.

Note: Binding of multiple logical `env`s to the zone is constraint by security classification for the zone (iter. 2)

#### Day 1 Operations:

1. Deploy LPro `preprod` environment to the `eastus_prod` zone:

   1. Add `eastus_prod` definition to `edge-local/promotions.yaml` file:
      ```yaml
      promotion:
        - name: preprod
          zones:
            - alias: eastus_prod
              name: platform-customer-eastus-01
              priority: 0
      ```
   1. Add required per-zone per-environment value overrides to `edge-local/values/platform-customer-eastus-01_preprod.yaml`
   1. Directory listing:
      ```text
      .
      └── 141-environment
          ├── edge-local
          │   ├── parameters.yaml
          │   ├── promotion.yaml
          │   └── values
          │       └── platform-customer-eastus-01_preprod.yaml
          └── external-secrets-resources
              ├── parameters.yaml
              ├── promotion.yaml
              └── values
                  └── platform-customer-eastus-01_preprod.yaml
      ```

1. Deploy LPro `prod` environment to the `eastus_prod` zone

   1. add `eastus_prod` definition to `promotions.yaml` file:
      ```yaml
      promotion:
        - name: preprod
          zones:
            - alias: eastus_prod
              name: platform-customer-eastus-01
              priority: 0
        - name: prod
          zones:
            - alias: eastus_prod
              name: platform-customer-eastus-01
              priority: 0
      ```
   1. add required per-zone per-environment value overrides to `edge-local/values/platform-engineering-eastus-01_preprod.yaml`
   1. Directory structure:
      ```text
      .
      └── 141-environment
          ├── edge-local
          │   ├── parameters.yaml
          │   ├── promotion.yaml
          │   └── values
          │       ├── platform-customer-eastus-01_preprod.yaml
          │       └── platform-customer-eastus-01_prod.yaml
          └── external-secrets-resources
              ├── parameters.yaml
              ├── promotion.yaml
              └── values
                  ├── platform-customer-eastus-01_preprod.yaml
                  └── platform-customer-eastus-01_prod.yaml
      ```

1. Deploy LPro `dev` environment to the `eastus_nonprod` zone
   1. Add `eastus_nonprod` definition to `promotions.yaml` file:
      ```yaml
      promotion:
        - name: dev
          zones:
            - alias: eastus_nonprod
              name: platform-engineering-eastus-01
              priority: 0
        - name: preprod
          zones:
            - alias: eastus_prod
              name: platform-customer-eastus-01
              priority: 0
        - name: prod
          zones:
            - alias: eastus_prod
              name: platform-customer-eastus-01
              priority: 0
      ```
   1. Add required per-zone per-environment value overrides to `edge-local/values/platform-engineering-eastus-01_dev.yaml`
   1. Directory structure:
      ```text
      .
      └── 141-environment
          ├── edge-local
          │   ├── parameters.yaml
          │   ├── promotion.yaml
          │   └── values
          │       ├── platform-engineering-eastus-01_dev.yaml
          │       ├── platform-customer-eastus-01_preprod.yaml
          │       └── platform-customer-eastus-01_prod.yaml
          └── external-secrets-resources
              ├── parameters.yaml
              ├── promotion.yaml
              └── values
                  ├── platform-engineering-eastus-01_dev.yaml
                  ├── platform-customer-eastus-01_preprod.yaml
                  └── platform-customer-eastus-01_prod.yaml
      ```

#### Day 2 Operations

1. Update `edge-local` configuration for preprod environment in `eastus_prod` zone

   1. Introduce a change to a `eastus_prod-preprod.yaml` value override file under `edge-local/values` folder.

1. Introduce same configuration value change to `edge-local` application for all environments across all zones defined in `promotion.yaml`

   1. Introduce a change to a `parameters.yaml` in a `edge-local` folder

1. Update `edge-local` chart version
   1. update chart version in `parameters.yaml` in the `edge-local` folder.

---

### 2. Need to deploy logical env across multiple zones.

Example: `preprod` logical environment spans `eastus_prod` and `westus_prod` zones.

#### Day 1 Operations

1. Deploy LPro `preprod` environment to the `eastus_prod` and `westus_prod` zone:
   1. Add `eastus_prod` and `westus_prod` definition to `promotions.yaml` file:
      ```yaml
      promotion:
        - name: preprod
          zones:
            - alias: eastus_prod
              name: platform-customer-eastus-01
              priority: 1 # Define priority for promotion within environment
            - alias: westus_prod
              name: platform-customer-westus-01
              priority: 2 # Define priority for promotion within environment
      ```
   1. Add required per-zone per-environment value overrides to `edge-local/values/platform-customer-eastus-01_preprod.yaml` and `edge-local/values/platform-customer-westus-01_preprod.yaml`
   1. Directory structure:
      ```text
      .
      └── 141-environment
          ├── edge-local
          │   ├── parameters.yaml
          │   ├── promotion.yaml
          │   └── values
          │       ├── platform-customer-eastus-01_preprod.yaml
          │       └── platform-customer-westus-01_preprod.yaml
          └── external-secrets-resources
              ├── parameters.yaml
              ├── promotion.yaml
              └── values
                  ├── platform-customer-eastus-01_preprod.yaml
                  └── platform-customer-westus-01_preprod.yaml
      ```

#### Day 2 Operations

1. Update `edge-local` configuration for preprod environment in `eastus_prod` zone

   1. Introduce a change to a `eastus_prod-preprod.yaml` value override file under `edge-local/values` folder.

1. Introduce same configuration value change to `edge-local` application for all environments across all zones defined in `promotion.yaml`

   1. Introduce a change to a `parameters.yaml` in a `edge-local` folder

1. Update `edge-local` chart version
   1. update chart version in `parameters.yaml` in the `edge-local` folder.

---

### 3. Need to offboard application for a logical env from the zone (iter. 2)

**Example**: `edge-local` app needs to be removed from `preprod` environment in `westus_prod` zone.

**Notes**:

- We need to udnerstand complexity involved related to surfacing deleted zones from promotion.yaml file vs having `delete: yes` flag added to a zone. While former improves user experience it may introduce technical difficulties that may not be required for iteration 1 of implementation. We need further analysis.

1. Update zone definition with `delete: yes` in `edge-local/promotion.yaml`
   ```yaml
   promotion:
     - name: preprod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1
         - alias: westus_prod
           name: platform-engineering-eastus-02
           priority: 2
           delete: yes
   ```
1. Remove zone specific overrides under `edge-local/values` folder
1. With the second PR, remove zone definition from `edge-local/promotion.yaml`
   ```yaml
   promotion:
     - name: preprod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1
   ```

---

### 4. Need to offboard application from multiple logical envs and multiple zones (iter. 2)

**Example**: `edge-local` app needs to be removed from `preprod` and `prod` environment in `westus_prod` zone. (iter. 2)

1. Update zone definition under `preprod` and `prod` environments with `delete: yes` in `edge-local/promotion.yaml`. Resulting file:
   ```yaml
   promotion:
     - name: preprod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1
         - alias: westus_prod
           name: platform-engineering-eastus-02
           priority: 2
           delete: yes
     - name: prod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1
         - alias: westus_prod
           name: platform-engineering-eastus-02
           priority: 2
           delete: yes
   ```
1. Remove zone specific overrides from `edge-local/values` folder.
1. With the second PR, remove zone definition from `edge-local/promotion.yaml`
   ```yaml
   promotion:
     - name: preprod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1
     - name: prod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1
   ```

---

### 5. Need to offboard all applications for a logical env from the zone

**Example**: `edge-local` and `external-secrets` app needs to be removed from `preprod` environment in `westus_prod` zone.

1. Modify `promotions.yaml` file for `edge-local` and `external-secrets` apps:
   ```yaml
   promotion:
     - name: preprod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1 # Define priority for promotion within environment
         - alias: westus_prod
           name: platform-engineering-westus-02
           priority: 2 # Define priority for promotion within environment
           delete: yes
   ```
1. Remove zone specific overrides under `<app>/values` folder
1. As subsequent commit remove zone definition from `<app>/promotion.yaml`
   ```yaml
   promotion:
     - name: preprod
       zones:
         - alias: eastus_prod
           name: platform-engineering-eastus-02
           priority: 1 # Define priority for promotion within environment
   ```

### Deployment environment (stage in the FO Pipeline v1)

1. New deployment zone added to the logical environment.
   Example: `westeurope_prod` zone added to `preprod` environment

## Day 2 Operations:

1. Add `westeurope_prod` zone to `preprod` logical environment.
1. Product/FO team needs to follow same steps as for deploying new logical environment to a zone.
   Main reason: unknown zone specific configuration.
   Questions:
   - How does app team discover the required configuration for the zone, ie Az KV name?

## Day2 operations with GitOps Promotion Pipeline

There are three main use cases related to Day2 operations. Those are:

- Modifications to `promotion.yaml`
- Modifications to `parameters.yaml`
- Per-zone value overrides in `<application>/values/<zone_name>_<env>.yaml`

---

## Folder listings for environment-apps repository

### `main` branch

```text
.
└── 141-environment
    ├── edge-local
    │   ├── parameters.yaml
    │   ├── promotion.yaml
    │   └── values
    │       ├── platform-customer-eastus-01_preprod.yaml
    │       ├── platform-customer-eastus-01_prod.yaml
    │       ├── platform-customer-westus-01_preprod.yaml
    │       ├── platform-customer-westus-01_prod.yaml
    │       ├── platform-engineering-eastus-01_dev.yaml
    │       └── platform-engineering-eastus-01_perf.yaml
    └── external-secretes-resources
        ├── parameters.yaml
        ├── promotion.yaml
        └── values
            ├── platform-engineering-eastus-01_dev.yaml
            └── platform-engineering-eastus-01_perf.yaml
```

### Content of `promotion.yaml` file for `edge-local` application

```yaml
promotion:
  - name: dev
    zones:
      - alias: eastus_nonprod
        name: platform-engineering-eastus-01
        priority: 0
  - name: perf
    zones:
      - alias: eastus_nonprod
        name: platform-engineering-eastus-01
        priority: 0
  - name: preprod
    zones:
      - alias: eastus_prod
        name: platform-customer-eastus-01
        priority: 1
      - alias: westus_prod
        name: platform-customer-westus-01
        priority: 2
  - name: prod
    zones:
      - alias: eastus_prod
        name: platform-customer-eastus-01
        priority: 1
      - alias: westus_prod
        name: platform-customer-westus-01
        priority: 2
```

### Content of `promotion.yaml` file for `exteral-secret-resources` application

```yaml
promotion:
  - name: dev
    zones:
      - alias: eastus_nonprod
        name: platform-engineering-eastus-01
        priority: 0
  - name: perf
    zones:
      - alias: eastus_nonprod
        name: platform-engineering-eastus-01
        priority: 0
```

### `release` branch

```text
├── platform-customer-eastus-01
│   ├── 141-environment-preprod
│   │   └── edge-local.yaml
│   └── 141-environment-prod
│       └── edge-local.yaml
├── platform-customer-westus-02
│   ├── 141-environment-preprod
│   │   └── edge-local.yaml
│   └── 141-environment-prod
│       └── edge-local.yaml
├── platform-engineering-eastus-01
│   ├── 141-environment-dev
│   │   ├── edge-local.yaml
│   │   └── exteranl-secrets-resources.yaml
│   └── 141-environment-perf
│       ├── edge-local.yaml
│       └── exteranl-secrets-resources.yaml
└── platform-engineering-westus-01
    ├── 141-environment-dev
    │   └── edge-local.yaml
    └── 141-environment-perf
        └── edge-local.yaml
```

---

## Glossary

**Logical Environment (LE)** implies logical grouping of helm charts. Examples:

- Edge-Local.
- External-secrets store.
- Secrets for environment backing services like MongoDB.

**Deployment Environment (DE)** implies binding to a LE for access to the secrets, ingress/egress apps, namespace for deploying product applications.
