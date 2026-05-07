---

title: ADR-0002 - Consistent Use Of Kubernetes Labels and Annotations across FusionOperate
status: accepted
date: 2023-09-20
deciders: @vladimir-babichev_finastra, @Andreas-Frangopoulos_finastra, @russell-yardley_finastra,
            @Josh-Vermast_finastra, @Eric-Skibicki_finastra, @Terry-Wallace_finastra
consulted: @vladimir-babichev_finastra, @Andreas-Frangopoulos_finastra, @russell-yardley_finastra,
            @Josh-Vermast_finastra, @Eric-Skibicki_finastra, @Terry-Wallace_finastra
informed: <DL-FO-Stability@finastra.com>, <DL-FO-Enablement@finastra.com>, <DL-FO-LaserPro@finastra.com>

---

## ADR-0002 - Consistent Use Of Kubernetes Labels and Annotations across FusionOperate

### Context and Problem Statement

As Fusion Operate platform scales and diversifies, there's a growing need for a standardized Kubernetes labeling system.
The current labeling mechanism is fragmented, leading to inefficiencies in resource management, querying, and
understanding. How can we ensure a consistent and scalable labeling system across the platform?

### Decision Drivers

- Need for clarity and consistency in resource identification.
- Scalability requirements for future platform growth.
- Ease of querying and managing resources based on labels.
- Ease of discovery additional information associated with resource.
- Minimization of operational overhead and confusion.

### Considered Options

- Maintain Current Labeling Scheme (combination of hierarchical domain-based and flat labeling schemes)
- Adopt Hierarchical Domain-Based Labeling Scheme
- Flat Labeling Scheme

### Decision Outcome

Chosen option: "Adopt Hierarchical Domain-Based Labeling Scheme", because it provides a clear, scalable, and structured
approach to labeling, ensuring ease of management and querying.

#### Consequences

- Good, because it supports scalability for future platform growth.
- Bad, because there is a learning curve for teams to adapt to the new scheme.
- Bad, because it will require to modify existing helm charts to support the new scheme.

### Pros and Cons of the Options

#### Maintain Current Labeling Scheme

Current labelling scheme is a combination of hierarchical domain-based and flat labeling schemes. It doesn't clearly
define supported domains and was used mainly as transition step in migration to a hierarchical domain-based labeling
scheme.

**Considerations**

- Good, because no migration is required.
- Bad, because it doesn't address fragmentation and inconsistency issues.
- Bad, because it may not scale well with platform growth.
- Bad, because it may lead to label collisions as the platform grows.

#### Adopt Hierarchical Domain-Based Labeling Scheme

Hierarchical domain-based labeling scheme implies labeling resources based on the domain or area of the business they
belong or relate to that can be described with following pattern: `[subdomain].<domain>.<product>.io`. For the
Fusion Operate domains are:

- `monitoring.fusionoperate.io`
- `platform.fusionoperate.io`
- `product.fusionoperate.io`

Refer to the [More Information](#more-information) section for example set of labels.

**Considerations**

- Good, because it provides a clear and structured approach.
- Good, because it's scalable for future platform growth.
- Good, because it provides discovery of additional supporting infromation by navigating to URLs encoded in the label.
- Neutral, because it introduces a new system that teams need to learn.
- Bad, because it will require to modify existing helm charts to support the new scheme.

#### Flat Labeling Scheme

Flat labeling scheme implies use of unstructured data for the `key` component in the `key/value` pair used for labels.
For example:

- `name=NACM`
- `product-id=153`
- `monitored=true`

**Considerations**

- Good, because it's simpler than a hierarchical approach.
- Bad, because it lacks the clarity and structure of the domain-based approach.
- Bad, because it may lead to label collisions as the platform grows.

### More Information

#### List of example labels

| Label                                                  | Type                | Sample Value   | Scope                                   | Description                                                                          |
| ------------------------------------------------------ | ------------------- | -------------- | --------------------------------------- | ------------------------------------------------------------------------------------ |
| `monitoring.fusionoperate.io/enabled`                  | `"true" or "false"` | `"true"`       | Namespace                               | Indicates wether Grafana Cloud monitoring enabled for the namespace.                 |
| `monitoring.fusionoperate.io/gc-stack`                 | `str`               | `fononprod141` | Namespace                               | Information about the Grafana Cloud Stack used for stroing metrics, logs and traces. |
| `platform.fusionoperate.io/deny-namespace-deletion`    | `"true" or "false"` | `"true"`       | Namespace                               | Admission controller instruction that prevents namespace deletion.                   |
| `platform.fusionoperate.io/resource-quotas-enabled`    | `"true" or "false"` | `"true"`       | Namespace                               | Admission controller instruction to set resource quoates for the namespace.          |
| `platform.fusionoperate.io/set-kube-service-host-fqdn` | `"true" or "false"` | `"true"`       | Deployment, DaemonSet, StatefulSet, Job | Mutating controller instruction to ensure Kube-Api service is called using FQDN.     |
| `platform.fusionoperate.io/node-type`                  | `str`               | `small`        | Node                                    | Type of FusionOperate node.                                                          |
| `product.fusionoperate.io/name`                        | `str`               | `FFDC`         | Namespace, Resources                    | Represents product's name.                                                           |
| `product.fusionoperate.io/id`                          | `str`               | `129`          | Namespace, Resources                    | Represents product's ID.                                                             |
| `product.fusionoperate.io/domain`                      | `str`               | `core`         | Namespace, Resources                    | Represents product's domain.                                                         |
| `product.fusionoperate.io/environment`                 | `str`               | `production`   | Namespace, Resources                    | Represents product's environment.                                                    |
