## Status

status: accepted\
date: 2023-09-26\
deciders: Architecture Forum\
consulted: Architecture Forum

---

## ADR-0004 Architecture Proposal Process

### Context and Problem Statement

The process surrounding architecture proposal leveraging the [PlatformArchitecture-docs](https://github.com/finastra-platform/PlatformArchitecture-docs)
git repo has raised numerous questions and discussions among the Architecture Forum team.

This includes:

- How do Feature Requests relate to Architectural Decision Records (ADRs) and Patterns?
- How do Architectural Decision Records (ADRs) relate to Patterns and vice versa?
- When is a Feature Request / Architectural Decision Record / Pattern required?  

### Decision Drivers

- Determine the relationship (if it exists) between Feature Requests, Architectural Decision Records (ADRs), and Patterns.
- Determine requirements to be met when creating a new Feature Request, Architectural Decision Record (ADR), or Pattern.

### Considered Options

- Independent Architectural Decision Record (ADR) and/or Pattern(s) dependent on formally submitted Feature Request.
- Independent Feature Request, Architectural Decision Record (ADR), and Pattern(s).

### Decision Outcome

Chosen option: Independent Feature Request, Architectural Decision Record (ADR), and Pattern(s), because this option
accommodates a variety of different workflows for creating new / changing existing features/capabilities of the platform.
Additionally, the system stays simple and intuitive for the current needs of the Architecture Group.

#### Consequences

- FusionOperate originiating Feature Requests don't require a formal GitHub issue be created, streamlining the architectural proposal process.
- Formal Feature Requests are optional (may be created for traceability if desired).
- Feature Requests, Architectural Decision Records, and Patterns stand independent of one another.
- Architectural proposal documentation creation is suited to need.
- Author(s) of a new architectural proposal are required to decide which artifacts to generate, which classification may be non-trivial.
- Feature Requests (requirements in the context of ADR / Pattern) behind Architectural Decision Record(s) and Pattern(s) may become
  harder to search for as a formal Feature Request is optional.

### Pros and Cons of the Options

#### Independent Architectural Decision Record (ADR) and/or Pattern(s) dependent on formally submitted Feature Request.

This proposal requires a Feature Request be formally submitted as an issue against the [PlatformArchitecture-docs](https://github.com/finastra-platform/PlatformArchitecture-docs)
GitHub repo using a provided issue template before creating an Architectural Decision Record (ADR) and/or Pattern.
Architectural Decision Record(s) (ADRs) and/or Pattern(s) will reference the created Feature Request.

Architectural Decision Record(s) (ADRs) and/or Pattern(s) may exist independent of one another.

- Good, because Feature Requests (requirements in the context of ADR / Pattern) are easily searched and don't require digging into ADR / Pattern documentation.
- Good, because a single defined Feature Request (requirement in the context of ADR / Pattern) can be referenced from an ADR and possibly multiple Patterns.
- Good, because documentation relative to the architectural proposal is suited to need.  If only a decision is required to be made,
  an ADR may be created without needing to create Pattern documentation.
- Neutral, because Feature Requests (requirements in the context of ADR / Pattern) exist independent of ADR / Pattern documentation.
- Netural, because it is up to the proposing author to identify whether an architectural proposal should be created as an Architectural Decision
  Record (ADR) or Pattern.  Sometimes the classification can be non-trivial.
- Bad, because a single ADR / Pattern referencing a Feature Request requires a separate document to be created rather than inlining
  the Feature Request in the ADR / Pattern.
- Bad, because a Feature Request may originate internally in FusionOperate and not require a formal GitHub issue be created.
- Bad, because a Feature Request is a complex document that requires detailed problem description, business justification and can be an overkill for simple ADRs like tool A vs tool B, aligning on the naming convention, etc.

#### Independent Feature Request, Architectural Decision Record (ADR), and Pattern(s).

This proposal suggests that Feature Requests(s), Architectural Decision Record(s) (ADRs) and/or Pattern(s) may exist independent of one another.

A customer *may* formally submit a Feature Request as an issue against the [PlatformArchitecture-docs](https://github.com/finastra-platform/PlatformArchitecture-docs)
GitHub repo.  Corresponding Architectural Decision Record (ADR) and/or Pattern(s) may reference the Feature Request.

Internally, FusionOperate team members may create Architectural Decision Records (ADRs) and/or Pattern(s) without requiring
a Feature Request being formally submitted as an issue.  The `Context and Problem Statement` and `Motivation` sections in the
Architectural Decision Record (ADR) and Pattern documentation may suffice as the requirement for these cases.

- Good because FusionOperate originiating Feature Requests don't require a formal GitHub issue be created.
- Good because a Feature Request may be generated for traceability and linked to an ADR / multiple Pattens.
- Good because artifacts associated with architectural decision making stand independent of each other, allowing maximum
  flexibility for convenience.
- Good, because documentation relative to the architectural proposal is suited to need.  If only a decision is required to be made,
  an ADR may be created without needing to create Pattern documentation.
- Good, because the system stays simple and intuitive for the current needs of the Architecture Group
- Netural, because it is up to the proposing author to identify whether an architectural proposal should be created as an Architectural Decision
  Record (ADR) or Pattern.  Sometimes the classification can be non-trivial.
- Bad because Feature Requests (requirements in the context of ADR / Pattern) behind Architectural Decision Record(s) and Pattern(s) may become harder to search for.

### More Information

The FusionOperate architecture team has defined the following taxonomy regarding architectural proposals:

#### To implement a simple mechanism for our consumers to request features

A *Feature Request* is a proposal for an enhancement or the development of new and complex functionality.
In any scenario, it marks the beginning of an architectural development cycle, which is quite an extensive endeavor.

At a minimum, a *Feature Request* should include:

- A comprehensive description of the enhancement or new functionality to be developed
- Anticipated outcome or desired system behavior
- A list of requirements, both functional and non-functional
- Quantifiable business value

The intended audience for *Feature Request*s would be:

- Stakeholders from organizations interacting with FusionOperate
- Internal stakeholders of FusionOperate

In essence, each *Feature Request* is a driving force for architectural refinement, ensuring the platform remains adaptive
and aligned with evolving needs and overarching business goals.

*Feature Request*s can be formally submitted as GitHub issues against the [PlatformArchitecture-docs](https://github.com/finastra-platform/PlatformArchitecture-docs) repo.

#### To record "decisions". For posterity and reference. And allow open and transparent conversations with consumers

An Architectural Decision (AD) is a justified software design choice that addresses a functional or non-functional requirement that is architecturally significant. An *Architectural Decision Record (ADR)* captures a single AD and its rationale; the collection of ADRs created and maintained in a project constitute its decision log. We use these to record architecturally significant decisions such as which technology to use for a particular use-case. e.g. Terraform vs Crossplane vs Pulumi for our Infrastructure as Code tooling.

#### To record designs. For obvious reasons and to allow collaboration/contribution with consumers.

A *Pattern* is a detailed design proposal for significant changes or new features. It provides a structured way for contributors to define, discuss, and refine their ideas, with feedback from the Architecture Forum. It also provides design context for posterity. If you are familiar with contributing to open-source projects then you will have heard of a RFC (request for comments). Patterns are exactly the same, they just use our naming convention.

#### Summary

In summary, an Architectural Decision Record is more focused on capturing a decision for historical and educational purposes, while a Pattern is geared towards collaborative decision-making. Both are vital tools as they facilitate transparency, foster communication, and ensure that important decisions are well-documented.
