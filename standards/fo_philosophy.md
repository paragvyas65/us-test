# Declarative State Management

Management of Fusion Operate resources is to be handled declaratively, rather than in imperative pipelines. When a consumer interacts with an FO API or an asset, this is done to declare state: e.g. a `POST /environments` or `PUT /environments/123` operations sets the desired state of the application deployment environment. This introduces several design implications:

1. Our APIs must support event sourcing. That is, they must support versioning of the resource, and client-managed cursor for iterating through resource changes. Additionally, they should support subscriptions, or change event notifications. The Kubernetes API Server is a excellent example of this.
1. Our tooling must support reconciliation loops, based on the state in the FO APIs. This to both bring the actual state into compliance with desired state eventually, and to alert on drift from desired state.

We should not reinvent many wheels. The primary Fusion Operate tools for application and infrastructure management provide this functionality: Terraform and Kubernetes.

## Mechanisms

In FO v2 (see [domain_model.md](./domain_model.md)), the mechanism for declaring state is by configuring Fusion Operate "apps"--helm charts that templatize the K8s state managed in each cluster. This is to leverage the Kubernetes tooling in an efficient, productive way given our present level of maturity. It is expected that we will introduce our own K8s Operators and Terraform provider in future versions to improve usability and clarity of intent for FO users.

For v2, management of these "FO Apps", or distinct helm releases configuring FO resources for products, should be managed via gitops.

# Apps

There are two types of FO applications represented below (and they need better names)

1. Those that are zone scope. These have a promotion pipeline and are for product to self-manage the bindings of their teams, domains, envs per zone.
1. Those that are global scope. These are "Provisioning" or "Onboarding". These need to be developed. There are 3 main options seen at present for implementation of the gitops experience.
   1. Just YAML, which is then applied to the FO Core APIs.
   1. They might be tf modules, if we author an fo-api provider.
   1. Helm charts, followed by Operators, just like the zone-scope apps. In this case, they would be applied to the management clusters for each tier

| App                       | Asset (Chart) Owner | Owner of release                                                         | Scope applied | Description                                                                                                                                                                                                                                             |
| ------------------------- | ------------------- | ------------------------------------------------------------------------ | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| fo-product-provisioning   | Core                | product                                                                  | global        | product provisioning, including PO, contact info, SNow integration                                                                                                                                                                                      |
| fo-team-provisoning       | Core                | product                                                                  | global        | team provisioning, managing AAD groups and team classification                                                                                                                                                                                          |
| ~~fo-universe~~           | CP                  | fo-CP                                                                    | global        | Not needed in chart (yet)                                                                                                                                                                                                                               |
| ~~fo-class~~              | CP                  | fo-CP                                                                    |               | ... these are defined in FO Core APIs                                                                                                                                                                                                                   |
| fo-zone                   | CP                  | fo-CP                                                                    | cluster       | "makes a cluster a registered fo zone"                                                                                                                                                                                                                  |
| fo-env-logical            | CP                  | product[^1]                                                              | zone          |                                                                                                                                                                                                                                                         |
| fo-env-deployment         | CP                  | product[^1]                                                              | zone          | provisions the namespace and logical env binding                                                                                                                                                                                                        |
| fo-domain                 | CP                  | product[^1]                                                              | zone          |                                                                                                                                                                                                                                                         |
| fo-product                | CP                  | provisions integration needed for AAD, ldapgroupsync, etc to the cluster | zone          | This is the self-service product definition that is bound to zones and promoted through a promotion pipeline                                                                                                                                            |
| edge-local                | CP                  | product (implied by its usage by fo-env-logical)                         |               |                                                                                                                                                                                                                                                         |
| fo-env-deployment-binding | CP                  | implied by the relationship between env-logical and env-deployment       |               | provisions the rules linking a deployment environment to a logical env. e.g. kubed or k8s-reflector[^2] config for secrets provisioning for tls config in Ingress resources, or image pull secrets, which are needed by apps in a dep env               |
| fo-kafka                  | Data Services       | Data Services                                                            | dep-env       | provisions the data-services domain, kafka dep env for a product                                                                                                                                                                                        |
| fo-kafka-service-binding  | Data Services       | product                                                                  | app           | provisions the rules linking the app deployment to the specific kafka broker; e.g. kubed or k8s-reflector config for secrets provisioning for Topic and User so that these can be replicated to app dep env and bound to app pod spec using known names |

[^1]: We need a governance process balancing self-service for products managing this state with oversight of key changes, e.g. involving network rules or name changes. This should involve the product governance chain, such as CODEOWNERS in the Product architecture, PO, and PDS champions in approval paths, with platform providing policy reporting and audit capabilities.
[^2]: Need a technology decision by container platform team on whether to use kubed or kubernetes-reflector for secrets sync in the binding cases.

## Control Plane vs Data Plane (FO perspective)

- The above zone-scoped apps are control plane apps in that they are related to products managing application deployment environments
- Fusion Operate also has zone-management scoped apps (essentially our control plane)
  - apps that are deployed and managed in the management zones
  - Aqua infra
  - API platform ctl plane
  - Salt needs decision, but implies mgmt is geo-bound

NOTE: More work is needed to clarify this.

# Charts Details from PI-11

By the end of PI-11, we had the below inventory of apps. This list is to indicate how these should change as the above definitions and design evolves.

| Chart                      | Provisioning Event | Change                | Parent app?   | Notes                                                                                                           |
| -------------------------- | ------------------ | --------------------- | ------------- | --------------------------------------------------------------------------------------------------------------- |
| aro-upgrade                | Zone               |                       | fo-zone       |                                                                                                                 |
| cert-manager               | Zone               |                       | fo-zone       |                                                                                                                 |
| cert-sync-resources        | Environment        |                       | fo-env        | This should transition to a CR managed within the edge-local chart                                              |
| cert-sync                  | Zone               | cert-binding-operator | fo-zone       |                                                                                                                 |
| edge-local-138             | Environment        |                       | fo-env        | Should aggregate/imply tfco-ingress through edge-local                                                          |
| external-secrets-resources | Domain             |                       | fo-domain     | Moves into domain chart                                                                                         |
| external-secrets           | Zone               |                       | fo-zone       |                                                                                                                 |
| fluent-bit-monitor         | Zone               | remove as sep chart   | fo-zone       |                                                                                                                 |
| group-sync-operator        | Zone               |                       | fo-zone       |                                                                                                                 |
| kubed                      | Zone               |                       | fo-zone       |                                                                                                                 |
| machineset-essence-kafka   | Domain             |                       | fo-domain     | Limit Risk: machine sets and node count                                                                         |
| machineset-gpp-kafka       | Domain             |                       | fo-domain     |                                                                                                                 |
| machineset-monitoring      | Domain             |                       | fo-domain     |                                                                                                                 |
| router-138-dev             | Environment        |                       | edge-local    | include replication config of the router certificate in all required namespaces                                 |
| router-essence-kafka       | Environment        |                       | edge-local    |                                                                                                                 |
| router-monitoring          | Environment        |                       | edge-local    |                                                                                                                 |
| router-pipeline            | Environment        |                       | edge-local    |                                                                                                                 |
| serverless-operator        | Zone               |                       | fo-zone       | owned by CP: serverless domain, to provide a serverless capability at a particular zone at a particular version |
| serverless-resources       | Zone               |                       | fo-zone       |                                                                                                                 |
| tfco-ingress-138           | Environment        |                       | edge-local    |                                                                                                                 |
| tfco-ingress-monitoring    | Environment        |                       | edge-local    |                                                                                                                 |
| tfco-ingress-pipeline      | Environment        |                       | edge-local    |                                                                                                                 |
| tfco                       | Domain             |                       | fo-domain     |                                                                                                                 |
| router-tmp                 | Zone               |                       | edge-local    | Unique for all tmp deployments. Include replication config of the router certificate in all required namespaces |
| aqua - next step           | ~~Tier~~           |                       | fo-zone-mgmt? | 2 ACRs per product, one for each fo-class, and all ACRs of a class are handled by the class Aqua instance       |
| aqua - future target       | ~~Universe~~       |                       | fo-zone-mgmt? | 1 ACRs per product, a unique Aqua instance to rule them all                                                     |
