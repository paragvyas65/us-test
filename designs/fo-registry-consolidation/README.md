# ACR consolidation

## Context

FO v1 historically provided a rigid set of deployment environments for each tenant, each of them owning its ACR to pull images from.
The deployment pipelines were taking care of promoting images from one ACR to the other.

Some of the reasons for this model:

- Performance: having an ACR sit next to each cluster
- Security: Product teams could have access to lower environment ACRs, but not to PreProd or Prod ones

Similarly, a ChartMuseum chart repository was provisioned for each environment (although shared across tenants), and the deployment pipelines were taking care of promoting charts from one ChartMuseum to the other.

As we move towards a more flexible and customizable definition of environments, and maybe to a gitops deployment model, the pipelines can't keep performing this image promotion, it just becomes a better choice to have a unique ACR used across all environments and hosting images and charts:

- Simpler

  - no need to provision a new ACR for each new environment
  - no need to register a new ACR in Aqua for each new environment
  - no image promotion flow supported by the deployment system
  - no duplication of information
  - less credentials to manage
  - less Aqua instances to set up and synchronize

- Faster
  - no more pull/push images across ACRs

But this also raises other concerns which were addressed by the previous model:

- How to ensure that images/charts used in production can't be deleted by users?
- How to ensure that images/charts used in production can't be replaced by users?
- How to ensure users can still experiment freely?

## Assumption

Internal and Platform tiers are entirely distincts, they don't serve the same purpose and no deployment pipeline is expected to deploy across both tiers:

- Internal tier dedicated to experimentation
- Platform tier dedicated to development and production

Each of them will get an ACR per tenant, governed by tier-specific rules.

## Single ACR model: not retained

`fo-registries.drawio.svg` shows the initial target with a unique ACR per tier and per tenant.

A single Aqua Ctrl-plane is required to scan this ACR, and drives Aqua enforcers on each environment, configured with a policy specific to the environment type (basically dev or prod).

On the Platform tier, the authenticity of images/charts is ensured by

- Preventing users to manually push to the ACR
- Signing the images/charts as part of the build pipeline execution, for develop and master branch builds (i.e. the ones to be deployed to stable environments)
- Preventing users to sign a forged image or to steal signing credentials from a malicious private feature branch. This is ensured by restricting the service connection granting access to the signing credentials to only the develop and master branch.

The signing is verified

- For charts, by the deployment pipeline
- For images, by a kubernetes admission controller (Connaisseur)

On the Internal tier, users can freely access the ACR, no signing is performed, and an Aqua ctrl-plance is stood up to monitor the ACR, without specific quality gate enforced.

**This solution is not retained for the following reason: The pipeline is granted access to the unique ACR. Although a user cannot forge a malicious signed image, he can still hack the pipeline on a private branch to replace or delete an image in the ACR, including those in use in production.**

## Dual ACR model: retained

To fix the issue of the previous model, we add one ACR, as depicted in `fo-registries-2ACRs.drawio.svg`:

- One "CD" ACR used for deployments to all stable environments, with signed images/charts,
- One "CI" ACR used for temporary deployments of pull requests and short-lived branches builds, with unsigned images/charts.

With this change, the "CD" ACR access is protected with a service connection restricted to the develop and master branches. The "CI" ACR is accessed with another unrestricted service connection.

---

# Requirement: Dev workloads on Customer zones

Ryan Parrish mentioned the need for CS/GS to deploy dev workloads on Customer class zones.

This is fulfilled by the design depicted in `label_based_aqua_runtime_policies.drawio.svg`:

Each environment in a zone has a type ("dev" | "prod").
This is materialized by an AquaScope label in a namespace.
This label is applied to the namespace pods by a kubernetes "pod-labeler" operator.
The pod label is the criteria used by Aqua to select the policy applied to the pod.

\*\*But this requirement raises a security concern: A relaxed policy on a dev pod might result in a vulnerable pod, used to compromise the zone hosting production workloads.

It is yet to be defined a restricted use case scope in which the security concern would vanish.\*\*
