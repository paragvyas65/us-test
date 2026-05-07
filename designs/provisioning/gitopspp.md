# GitOps Flux Implementation Changes

## For Zone Management (STIZ Acceptance Criteria)

Scope of work for GitOps Flux changes for STIZ work

- Only covering zone management, not product application delivery to Zones.
- Keeping constraint of "1 promotion flow per repo"
- Must backlog design sessions dedicated to improving the Flux-based GitOps "pipeline", after movement to STIZ for tenants, and after products switch to build pipelines. "after" means once these efforts are done from a design perspective and the migration work is underway.

Required usability changes to current GitOpsPP

1. Switch from tier+class+region to environment names and zone names for promotion definition
2. promotion.yaml DRY at root of repo; only one promotion flow per repo
3. Release management:
   1. dev and test of "platform apps" happens in "platform zones" (e.g. platform-sut1 -> platform-eng-uat -> platform-mgmt-01)
   2. rollout of new versions of "platform apps" in product zones happens based on the product zones promotion.yaml (e.g. laserpro-dev -> laserpro-perf -> laserpro-prod, etc)
4. Introduction of application values.yaml change for a single zone should not
   require full run through of promotion pipeline; E.g. changing replica size for prod cluster deployment of tenant-api
5. Unified approval process for introduction of change - Today: one set of approvers for PR change, one set (different) of approvers for GitHub Actions run. Target - ONLY PR APPROVAL NEEDED
6. Required for "only PR approval needed" - distinct PR needed for each zone "promotion"
7. Enhance GitHub Actions reporting to clarify what is being changed by that action. Ensure depiction of actual config changes made on release branch to both the GitHub Action run and the main branch PR that originated it. https://jira.finastra.com/browse/FOP-2000
8. Feedback to the GitHub GitOps repo as to success/failure of the HelmRelease application in cluster by Flux; https://jira.finastra.com/browse/FOP-2001
9. Solve for visibility of application version across environments in a central "report"/UI

## Target Experience for GitOpsPP

Promotion Checks

1. promotion flow governs change promotion for code, not config
   Main PR checks
   - is change isolated to values/\*\*? if yes, no promotion check
   - does change involve global-config.yaml? if yes, then promotion check is applied; examples: new chart version, new namespace, new label
2. Promotion check implementation
   - does the success tag exist for this app-version for the "prior" zone?

Scenarios

1. New app, or new app version
   - dev creates PR against main, changing promotion or parameters
   - promotion check is engaged
   - if promotion check passes, then PR against release/{first-zone-in-promotion.yaml}-folder is created; product governance must approve
   - after approval,
     - merge is applied
     - PR against release/(next-zone-in-promotion.yaml}-folder is created)
     - rinse and repeat
2. Config change only for existing, deployed app version (values.yaml)
   - dev creates PR against main values/{zone}.yaml
   - promotion check is not engaged
   - PR is created against release/{zone} folder
   - no new PR for next zone is created
3. Hotfix, direct app change against zone
   - can create PR directly against release branch
   - won't be reflected in main
   - will be overridden durign next promotion flow

```
git://laserpro-zone-apps
(release branch of today's GitOpsPP)
/zone1
   /- prometheus-in-cluster.yaml
   |- cert-manager.yaml
/zone2/helmreleases.yaml

git://prometheus-in-cluster
/chart code
/app code
/test code
/alerts code
/promotion
   |- promotion.yaml
   |- parameters-global.yaml
   |- values/...yaml
```

### Two Models for interaction between app repo and flux gitops repo

1. use of gitopspp in the zone-apps repo; main is the promotion pipeline definition and release is the generated, governed state
2. use of gitopspp in the apps repo; folder in apps repo with promotion pipeline definition, workflow and gitopspp interacts with remote zone-apps repo (directly to release branch?)

## Usage and Roadmap for gitopspp usage

- Platform zonal apps uses model #1 against {product}-Zone-Apps repo
- Product microservices app would use model #2, also against {product}-Zone-Apps repo.
  - segment by product/platform (like infra gitops), or segment by namespace, and codeowners per namespace?
- Roadmap
  - Option 2 is viewed as "support for product GitOpsPP release pipeline
  - Implementation comes after Option 1 maturation backlog
  - Implementation comes after build pipeline v1 replacement

## Questions

Do we target a full native GitHub "repo" experience?

- releases - local github releases
- binary artifacts (charts, images, npm, maven, etc) - local github packages
- environments - kept in sync with promotion flow
