---

title: ADR-0003 - Adoption of Kyverno as a Mutating Webhook Controller
status: accepted
date: 2023-09-20
deciders: @vladimir-babichev_finastra, @Andreas-Frangopoulos_finastra, @russell-yardley_finastra, @Josh-Vermast_finastra, @Eric-Skibicki_finastra, @Terry-Wallace_finastra
consulted: @vladimir-babichev_finastra, @Andreas-Frangopoulos_finastra, @russell-yardley_finastra, @Josh-Vermast_finastra, @Eric-Skibicki_finastra, @Terry-Wallace_finastra
informed: <DL-FO-Stability@finastra.com>, <DL-FO-Enablement@finastra.com>, <DL-FO-LaserPro@finastra.com>

---

## ADR-0003 - Adoption of Kyverno as a Mutating Webhook Controller

### Context and Problem Statement

Fusion Operate requires a reliable mutating webhook controller to modify Kubernetes API requests in real time. The example use cases include, but are not limited to:

- updating container registry used by pod definitions;
- appending image-pull-secret to application pods;
- adding annotations and labels to objects;
- replicating namespace labels to downstream objects like pods;
- patch resource configuration (i.e., prepend/insert/append settings).

The challenge is selecting a solution that supports the use cases listed above, is efficient, maintainable and reduces maintenance overhead.

### Decision Drivers

- Support use cases listed in the "Context and Problem Statement" section.
- Integration capabilities with existing systems.
- Maintenance overhead and community support.
- Flexibility and extensibility for future requirements.

### Considered Options

- Adoption of Kyverno Mutating Webhook Controller
- Adoption of OPA Gatekeeper Mutating Webhook Controller
- Adoption of jsPolicy Mutating Webhook Controller
- Development of an In-House solution.

### Decision Outcome

Chosen option: "Adopt Kyverno's Mutating Webhook Controller", because it:

- supports use cases listed in the "Context and Problem Statement" section;
- provides ability to modify vast majority of resource parameters;
- is a CNCF incubating project;
- has a strong community backing.

#### Consequences

- Good, because it allows for regex pattern matching and partial resource value modifications.
- Good, because it has excessive documentation covering many use-cases.
- Neutral, because it uses widely adopted by Kubernetes community JMESPath query language.
- Neutral, because we will deploy Kyverno alongside OPA Gatekeeper, which is used as an Admission Controller.
- Bad, because it requires migration of existing mutating webhooks from OPA Gatekeeper.

### Pros and Cons of the Options

#### Adopt Kyverno's Mutating Webhook Controller

Kyverno is a policy engine designed for Kubernetes. It can validate, mutate, and generate configurations using admission controls and background scans.

- [Github](https://github.com/kyverno/kyverno/)
- [Docs](https://kyverno.io/docs/)
- [Website](https://kyverno.io/)

**Considerations**

- Good, because it supports all the use cases listed in the "Context and Problem Statement" section.
- Good, because it allows for regex pattern matching and partial resource modifications.
- Good, because it supports mutation of existing resources.
- Good, because it has excessive documentation covering many use-cases.
- Good, because it has a great policy library.
- Good, because it's a well-established solution with a broad user base.
- Good, because it is a CNCF incubating project.
- Good, because it has a strong community backing: 4.4k stars, 6,556 commits from 251 contributors.
- Neutral, because it uses widely adopted by Kubernetes community JMESPath query language.
- Neutral, because it's a new system that teams need to learn.

#### Adopt OPA Gatekeeper's Mutating Webhook Controller

Gatekeeper is a customizable cloud native policy controller that helps enforce policies and strengthen governance.

- [Github](https://github.com/open-policy-agent/gatekeeper)
- [Docs](https://open-policy-agent.github.io/gatekeeper/website/docs/)
- [Website](https://open-policy-agent.github.io/gatekeeper/website/)

**Considerations**

- Good, because it has a great policy library.
- Good, because it supports management of Mutating Webhooks as well as Policy management.
- Good, because it is a well-established solution with a broad user base.
- Good, because it is a CNCF graduated project.
- Good, because it has a strong community backing: 3.2k stars, 1,397 commits from 198 contributors.
- Neutral, because it doesn't have support for mutating existing resources.
- Bad, because its mutating controller doesn't support:
  - value based conditional mutations;
  - regex pattern matching;
  - partial value modifications.
- Bad, because mutations controller doesn't support following use cases:
  - replicating namespace labels to downstream objects like pods;
  - patch resource configuration (ie, prepend/insert/append settings).

#### Adopt jsPolicy Mutating Webhook Controller

jsPolicy is a policy engine for Kubernetes that allows you to write policies in JavaScript or TypeScript.

- [Github](https://github.com/loft-sh/jspolicy)
- [Docs](https://www.jspolicy.com/docs/why-jspolicy)
- [Website](https://www.jspolicy.com/)

**Considerations**

- Good, because it supports all the use cases listed in the "Context and Problem Statement" section.
- Good, because it supports JavaScript and TypeScript for policies and webhooks, which simplify implementation for complex use-cases.
- Bad, because it is not a CNCF adopted project.
- Bad, because it has a small user-base and community build around it: 298 stars, 135 commits from 13 contributors.
- Bad, because it had less than 10 commits in the last 12 months.

#### Develop an In-House Mutating Webhook Controller

- Good, because it offers full control and customization.
- Neutral, because it would be tailored to Fusion Operate's specific needs.
- Bad, because it will require development a separate controller for every use case from "Context and Problem Statement" section.
- Bad, because it requires significant development and maintenance efforts.
- Bad, because it lacks the community support and updates that come with open-source solutions.

### More Information

#### Comparison Table

| Feature/Capability                                    | Kyverno                                  | OPA Gatekeeper                           | jsPolicy                            | In-House Solution  |
| ----------------------------------------------------- | ---------------------------------------- | ---------------------------------------- | ----------------------------------- | ------------------ |
| Supports required usecases                            | :white_check_mark:                       | :x:                                      | :white_check_mark:                  | :white_check_mark: |
| Regex pattern matching                                | :white_check_mark:                       | :x:                                      | :white_check_mark:                  | :white_check_mark: |
| Partial resource modification (prepend/insert/append) | :white_check_mark:                       | :x:                                      | :white_check_mark:                  | :white_check_mark: |
| Mutation of existing resources                        | :white_check_mark:                       | :x:                                      | :x:                                 | :x:                |
| Documentation                                         | :white_check_mark:                       | :white_check_mark:                       | :white_check_mark:                  | :x:                |
| Policy sample library                                 | :white_check_mark:                       | :white_check_mark:                       | :white_check_mark:                  | :x:                |
| Number of community mutation samples                  | 81                                       | 18                                       | 4                                   | :x:                |
| Flexibility and extensibility                         | :white_check_mark:                       | :white_check_mark:                       | :white_check_mark:                  | :x:                |
| Maintenance overhead                                  | Low                                      | Low                                      | ?                                   | High               |
| CNCF status                                           | Incubation                               | Graduated                                | N/A                                 | N/A                |
| GitHub status (stars, commits, contributors)          | 4.4k :star:, 6,556 :keyboard:, 251 :man: | 3.2k :star:, 1,397 :keyboard:, 198 :man: | 298:star:, 135 :keyboard:, 13 :man: | N/A                |

#### Links:

- [Kyverno Fundamentals Certification](https://learn.nirmata.com/courses/kyverno-fundamentals-certification)
- [Kubernetes Policy Comparison: OPA/Gatekeeper vs Kyverno](https://neonmirrors.net/post/2021-02/kubernetes-policy-comparison-opa-gatekeeper-vs-kyverno/)
- [Kubernetes Policy Management Tools Compared - OPA with Gatekeeper vs. Kyverno (video)](https://www.youtube.com/watch?v=9gSrRNmmKBc)
