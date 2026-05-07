Provisioning steps

Criteria: has FO Product Global Infra

1. team onbaroding to GH
2. repo created
3. codeowners setup correctly
4. team onboarded to TFC
5. repo bound

TFC Provisioning for Zone infra repo

- per zone:
  - tfc workspace & Azure resource group for the LPC-Zone-Infra gitops repo (tenant-mgmt has global permissions; after this the product repos/SPs have constrained permissions to the RG)
  - tfc workspace for AKS infrastructure
  - tfc workspace for flux bootstrap
    Implementation Note: tenant-mgmt/laserpro.yaml -> local zone-module config -> outputs -> laserpro-zone-infra

Potential Backlog

1. optimize performance of aks module sldc? e.g. segment the aks_env module (optimization, so consider other strategies like test optimization--shorten initial feedback loop with unit tests)

Questions

1. How to handle AAD group membership changes, reflecting provisioning changes across our tools?
   Potential: cron-triggered job for reconcile loop of tenant-mgmt to pick up group changes (e.g. SLO: 1 hr)
   Potential: augment with change event trigger (e.g. AAD change event) (SLO: 5 mins)
   Consider: segmenting reconciliation for only group membership
   Design thought: input yaml processed into subfolders for the segmentation by tfc workspace, reconcile freq, governance, etc?

2. Use GH template repos for Terraform and FluxCD GitOps repos?
   If so, we need to establish the template -> child repo sync for propagating
   changes from template

3. Need details for acceptance testing for each provisioning success criteria

Target State for GitOps/Provisioning?

At start of STIZ work with LPC:
10 gitops repos

At today's GitOps pipeline maturity:

1. tenant-mgmt
2. product-zone-infra (tfc gitops)
3. product-zone-apps (fluxcd for zone)
4. product-infra (tfc for product resources)
5. product-apps (fluxcd for product apps)

Pros: clear understanding of lifecycle mgmt for tfc, vs fluxcd

Alternative 1a: converge by function (thing being changed)

1. tenant-mgmt
2. product-zone-mgmt (covers both tfc and fluxcd)
3. product-infra
4. product-apps

Alternative 1b:
can #3 and #4 be combined into `product-apps-mgmt`, which would have app and infra pipelines together?

1. tenant-mgmt
2. product-zone-mgmt (covers both tfc and fluxcd)
3. product-app-mgmt

Alternative 2: converge by tool/"pipeline"

1. tenant-mgmt
2. product-infra (tfc gitops); sub folders for zone-infra/ and product-infra/
3. product-apps (fluxcd for zone); sub folder for zone-apps/ and products-apps

# Product/Developer Notes

- Run experience blameless postmortems
- Record required exercises for on-boarding
- Institutionalize dojo model
