# Provisioning Events

## Product On-boarding

1. Intake ticket filling out initial information in the product-provisioning app
   - Product ID creation approval results in Product creation via the CESS API
   - Approvals
     - Approvers: Tim Sutherland, Harbinder Kang, or Leigh Brackley
     - Mechanism: JIRA progression; PR approval in the resulting repo
   - Teams?
   - Domains for your product?
   - Roles
     - Base roles that FO needs to be there at the start (KV, etc)
     - question in intake: "what resources do you need to provision for your applications, for which domains?" (e.g. postgres, redis, etc)
   - Provisioning of TF Cloud workspace and access to product owner is the result, bound to repo that is handed off to PO
1. Intake ticket activity happens in FO-Provisioning repo, which has the top-level product provisioning used for boot-strapping the self-service product repo.
1. Self-service repo is provisioned and bound to TF Cloud workspace
   - resources in repo: product, team, domain definitions that are self-service; must exclude ProductID
   - codeowners for product changes: fo-governance (JIRA to define the FO governance)
   - codeowners for non-product changes: self service within the product team (JIRA to define self-service experience)
   - Need JIRA to move the Product repo creation to this project

Examples:

FO Provisioning Repo (Owner: Fusion Operate Core)
This is bound to a TF Workspace used for product on-boarding. This repo contains the set of tf definitions used to bootstrap the product self-service repos.

finastra-platform/fo-provisioning/{product}/_.tf - tf project to create items in #1 above
finastra-platform/fo-provisioning/ffdc/_.tf
finastra-platform/fo-provisioning/lendercomm/_yaml|_.tf

Two Resulting Product-specific repos must be provisioning and registered with TF Cloud and ACM:

finastra-platform/ffdc-fo-global (owned by product) (this is the repo serving the role of #3 above, managing global-scoped apps)
TF-Cloud tracked project
-/ defining product level configuration that is allowed self-service (e.g. domain, teams, distribution lists)

finatra-platform/ffdc-fo-zonal (owned by product) (this is a the self-service repo managing zone-scoped apps)
ACM-tracked promotion of fo-product, fo-domain, fo-env-logical, fo-env-deployment (in zone-scoped list above)
-/promotion.yaml,
parameters.yaml,
/values/{zone-specific}.yaml

TODO Arch Backlog: Rationalize difference between ffdc-fo-global, ffdc-fo-zonal product definitions
TODO Arch Backlog: Reconsider GitHub Org/Team/Repo structure. Maybe org-per-fo-tenant

## Zone

- aro-env|aks-env module configured in tf repo. This manages the zone environment
- fo-zone app is installed in cluster, registering it as a zone. This attaches it to ACM, Aqua, etc, as covered in the fo-zone app.

## Product to Zone

- Product gets repo for defining their zone-scoped apps. These are the applications above marked zone-scope, which have promotion pipeline (what resources go in which cluster).
- Repo name: <product>-ACM-<somethingTBD>, with <product> team PR submission permission.

### Questions

1. How does a product become aware of new zone availability in promotion pipeline? Can be announcement now.

## Deployment Environment to Zone
