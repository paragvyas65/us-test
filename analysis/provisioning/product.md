Provisioning Events: Product

# FO Event 1.1

_Product Provisioning, Scenario 1_: On-boarding P2Go Product to Fusion Operate

_Status_: In-progress. Active analysis on-going in arch sessions

## Success Criteria

### 1.0

Product able to request app repos and pipelines for those apps, and those pipelines "work" up to preprod.

Domains: Pipelines, DevTools, Kubernetes, SRE/Observability, Delivery, Operations

## Trigger

JIRA Story via template at docs site

## Discovery

https://docs.fusionoperate.io/docs/getting_started/onboarding/project_onboarding/

## Prerequisite State

Input for intake activities are captured in the ServiceNow tickets used to govern these provisioning activities. (TODO: put SNow references)

1. IT Intake: all members of the product team have been on-boarded as Finastra engineers, via IT Help Desk on-boarding; provides finastra.com account
1. DevTools Intake: all members of the product team have been on-boarded via "DevTools intake" to provision MDSN license, DH.com account, DevTools access (confluence, JIRA, DefectDojo, Checkmarx, Whitesource, Sonar)
1. Product exists in CESS v2 API; detached from Finastra IT provisioning; verification

# Steps

Instructions are at https://finastra.stackenterprise.co/questions/307 (SO-307)

### High-level

1. Perform manual provisioning pre-requisites listed as steps 1-6 in SO-307; record role ids, pids, etc for use in later stages (e.g. OP env-specific config). For details on TF-based managed of these items, please see the [cess.md](cess.md) analysis.
1. Add team to [FusionOperate-onboarding/OperatingPlatform](https://github.com/finastra-platform/FusionOperate-onboarding/tree/master/OperatingPlatform/teams_definition); create new team folder using env-specific templates, filling out with intake JIRA, and inputs from the manual actions in SO post 307 (see above)
1. Add new team to parameter list in the onboarding [azure-pipeline.yaml](https://github.com/finastra-platform/FusionOperate-onboarding/blob/master/azure-pipelines.yml). NOTE: this step is missing from steps 7-8 in SO-307
1. perform steps 9 of SO-307
   1. step 9: run onboarding pipeline with "create_sp" flag for each environment. These service principals have access to the Azure resources (aks, acr, kv).
   - SP name is determined, and then set in the PR per env under /OP/teams_def/
   - tokens are needed to create SP - this is PAT in DHOPS org
   - tokens are needed to create new project in FusionFabric org - this is PAT in fusionfabric org
1. selecting "new_project" disables the SF and MP stages. Run for Dev with creat_sp and new_project. Then run for each env with only create_sp selected.
1. Prior to step 10, do privilege escalation. Needs details added to documentation
1. Run step 10 to create the AzDO service connections and the k8s service connections
1. provision image pull capability for product to each cluster product binds to (step 11). Note: goes away with consolidated ACRs
1. provisions privileges to use KVs (step 12). FO service binding KV reads:

1. Run the onboarding pipeline in a specific sequence to do things like

   - run SF stages of pipeline to create the [pipeline_templates/{team}](https://fusionfabric.visualstudio.com/FusionOperate/_git/pipeline_templates?path=/tmpl/fusionfabric) folder for AzDO inheritance and overrides
   - provision dependencies hinted at in step 9 of SO-307, which are options when running the onboarding pipeline
   - run each env-specific stage of on-boarding pipeline for OperatingPlatform provisioning
   - run MonitoringPlatform stage for that provisioning
   - create the teams Wiki page under their "AzDO/FusionFabric/{Project}/wiki"

### Backlog Items

1. platform service on-boarding, def of done must include discovery and integration to provisioning events; This will happen as part of the on-going arch sessions on provisioning
1. Move [SO-307](https://finastra.stackenterprise.co/questions/307) & [SO-237](https://finastra.stackenterprise.co/questions/237) to FO Docs site | [Project Onboarding](https://docs.fusionoperate.io/docs/fo_internal_docs/internal_project_onboarding/), clean up to clarify missing steps, as indicated above ([FO-13622](https://jira.finastra.com/browse/FO-13622) - Venky)
1. Fix onboarding JIRA: Kong to be added to product intake ([FO-13619](https://jira.finastra.com/browse/FO-13619) - Slawek)
1. Fix onboarding JIRA: Quotas are set, but not asked of product ([FO-13619](https://jira.finastra.com/browse/FO-13619) - Slawek)
1. Document set of permissions needed by our engineers to manually run the scripts ([FO-13621](https://jira.finastra.com/browse/FO-13621) - Abdul)
1. Document set of permissions needed by SPs used by the pipeline to run the pipeline provisioning (?)
1. Document all of the config that onboarding creates (by default and what requires separate request) and uses in KV and AppConfig: keys and how used, documented in one place ([FO-13623](https://jira.finastra.com/browse/FO-13623) - Andreas)
1. Container Platform analysis of zone mgmt for managing FO clusters, including migration path.
1. Analysis for importing terraform state for zone (e.g. recreate service principals that have the same privileges as existing, but managed by the module)
1. Migration plan for new zones and products moving to them
1. Design user experience for firewall rule management separate from the management of the firewall rules in the fw mgmt repo. e.g. what happens for firewall rule management and governance process for the tf-repos when environment { egress_ports: [] } CR appears in a zone? (NOTE: defer until poc operator v1 is present)

### Next Action Items

In arch provisioning sessions, week of May 30, we will

1. walk through sequence and create a diagram of on-boarding pipeline interactions (they must be performed in a particular order)
1. have a design session on what this would look like as a terraform project
1. explore if service principal process can be automated and, perhaps, leverage AAD groups
1. extend the tf project design with a clear statement of how all domains can hook into provisioning
   - all automation must be part of the singular tf global onboarding project
   - or setup repo/pipeline dependencies (e.g. webhooks between Cloud + CP + SF + MP repos)

# FO Event 1.2

_Product Provisioning, Scenario 2_: P2Go Changing product-level config (e.g. quota)

_Status_: Not Started

# DevTools Event

_Status_: Not Started; Need identified

### Context

1. With FO 1.0, DevTools intake is a separate activity, though required for product onboarding. We want to move this into consolidated FO provisioning with 2.0 (i.e. Dev Tools is part of the FO domains).
1. DevTools IAM is separate from FO IAM
1. Does DevTools IAM control Azure portal access? Are they the same AAD groups as used for tools (confluence et al) access control?

### Success Criteria

- User in the Product's teams can log into, via SSO, to all tools (authn)
- User in the Product's teams can see all resources belonging to the product in each tool, from Azure Portal, to Atlassian stack, to security tools, etc (authz)

DevTools Intake: all members of the product team have been on-boarded via "DevTools intake" to provision MDSN license, DH.com account, DevTools access (confluence, JIRA, DefectDojo, Checkmarx, Whitesource, Sonar)

### Action Items

- Comprehensive list of services and what domains they belong to (see spreadsheet; harbs to send link)
