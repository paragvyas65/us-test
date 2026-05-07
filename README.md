# Platform Architecture

## Introduction

This repository acts as a centralized location for the Architecture Forum to manage and discuss architectural proposals
within our project. It is intended to be a hub for collaboration, where contributors can propose and discuss Feature
Requests, Patterns (aka RFCs), Architectural Decision Records (ADRs), and Standards documents.

Our processes are entirely Git-based, providing a consistent and transparent way to move from initial ideas to
fully realized designs.

## Definitions

### Feature Request

A Feature Request is a proposal for a new functionality or an enhancement to existing functionality. Further details on
how to submit a Feature Request are outlined below.

### Patterns

An Pattern is a detailed design proposal for significant changes or new features. It provides a structured way for
contributors to define, discuss, and refine their ideas, with feedback from the Architecture Forum. It also provides
design context for posterity. If you are familiar with contributing to open-
source projects then you will have heard of an RFC (Request for comments).
Patterns are exactly the same, they just use our naming conventions.

### Architecture Decision Records (ADRs)

An Architectural Decision (AD) is a justified software design choice that addresses a functional or non-functional
requirement that is architecturally significant. An Architectural Decision Record (ADR)
captures a single AD and its rationale; the collection of ADRs created and maintained in a project constitute its
decision log. We use these to record architecturally significant decisions such as which technology to use for
a particular use-case. e.g. Terraform vs Crossplane vs Pulumi for our Infrastructure
as Code tooling.

## Contributing

Contributors are encouraged to participate in the ongoing development by submitting Feature Requests or Patterns. Here's
how to get involved:

### Feature Requests

Feature Requests should be submitted as issues using the provided issue template. This will help ensure that all
necessary information is included and facilitate a more efficient discussion and evaluation.

### Patterns

To propose an Pattern, follow these steps:

1. **Copy the Template**: Copy the `pattern.tmpl.md` file from the root folder to the `patterns` directory, and name it
   `XXXX-{short title}.md` , where `XXXX` is the next available Pattern number. If your pattern requires significant
   documentation, as would be applicable for a large change, then create a directory called `XXXX-{short title}` instead
   and place all relevant files and diagrams inside it.
2. **Fill in the Details**: Populate the file with the specific details of your Pattern, ensuring that all mandatory
   sections are completed.
3. **Create a Pull Request**: Submit a pull request (PR) with your Pattern. Include any additional context or information
   that may assist in the review.
4. **Discussion and Review**: The Architecture Forum will discuss the Pattern, possibly requesting further information or
   changes. The aim is to ensure the design is sound and aligns with the goals of the Platform.
5. **Approval and Merge**: If the Pattern is accepted, the PR will be merged. Note that merging indicates an intention
   to work on the proposal, but does not guarantee that work will begin immediately. Your PR will be tagged with the current
   status ("queued", "selected for development" etc.) so check back on it regularly or keep an eye on the Roadmap to see
   when your feature will be worked on actively.

### Architecture Decision Records

To create an ADR, follow these steps:

1. **Copy the Template**: Copy the `adr.tmpl.md` file from the root folder to the `adr` directory, and name it
   `XXXX-{short-title}.md`, where `XXXX` is the next available Pattern number.
1. **Fill in the Details**: Populate the file with the specific details of your ADR, ensuring that all mandatory
   sections are completed.
1. **Create a Pull Request**: Submit a pull request (PR) with your ADR. Include any additional context or information
   that may assist in the review. If there are security implications, a DevSecOps or Security architect will be
   added as a required reviewer.
1. **Discussion and Review**: The Architecture Forum will discuss the ADR, possibly requesting further information or
   changes. The aim is to ensure the design is sound and aligns with the goals of the Platform.
1. **Approval and Merge**: If the ADR is accepted, the status will be updated accordingly and the PR will be merged.
   Once the status is set to accepted, the decision is codified and must be adhered to.

## Additional Notes

- **Communication**: Collaborators are encouraged to actively engage in discussions on PRs and issues. Respectful
  and constructive feedback is expected from all participants.
- **Expectations**: Acceptance of an Pattern does not imply immediate implementation. Scheduling, resources, and other
  considerations may influence when work begins.

## Support and Questions

For general questions or support, please open an issue or contact the Architecture Forum directly.

Your participation and collaboration are greatly appreciated!
