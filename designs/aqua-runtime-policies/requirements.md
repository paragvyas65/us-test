# Policy definition requirements

## DevSecOps use cases

### Common to all policies

- Full exception for a tenant (different cluster, ACRs, ...), so that it can be managed manually externally
- DevSecops must be able to define a default policy to all scopes, which tenants can can override, either to add more controls or to relax or removed some of them (example: Some volume mounts blocked by a default policy should be allowed for some tenants (platform))

### Image assurance policies

- Non negotiable controls enforced to all scopes which can't be overridden (example: Malware, sensitive Data). Some in audit mode, some in enforce mode.
- Catch-all policy enforced to scopes which don't have more specific policies, as a way to detect missing policies for a given scope. For example, if an ACR or a zone is added and policies are not re-generated accordingly.
- Need to support the policy CVE exception global setting as a regular control until the Aqua CVE acknowledgement is fixed

### Runtime policies

- Non negotiable controls enforced to all scopes which can't be overridden (example: Block cryptocurrency mining, Bad IP, Drift prevention on Linux machines)
- Non negotiable controls for specific environments (example: forbid root user). They can obviously also define exceptions, such as Calico images. In higher environments: enforce mode. In lower environments: audit mode. Environments where they must be enforced would need to be explicitly specified, and the controls would run in audit mode otherwise. DevSecOps workflow is usually to start in audit mode, and switch some controls to enforced mode later on.
- Catch-all policy enforced to scopes which don't have more specific policies, as a way to detect missing policies for a given scope

### Other assurance policies (host or K8S or function)

- the only current need is a default policy in audit mode, because we can't fix these things easily by ourself anyway

## LaserPro use cases

- Need to override runtime policies by environment
- Need to override at the image level. (example: whitelisting executables allowed to run in an image)
- Non negotiable controls should first be enforced to lower envs and kept in higher envs in audit mode, before they are enforced globally or only on higher envs

## Additional use cases

- It must be possible to define a tenant scope by the tenant ACRs _and_ the tenant image name pattern (because FFDC and openAccess share the same Dev ACR)

## Answered questions

- No need to apply different policies on the staging and the prod Ctrl planes
- No need to apply different policies on Linux and Windows
- An override must be able to fully disable a check enabled from a more global policy
- An override must be able to switch a check from a more global policy from Enforce to Audit mode
- Some control settings contain list(s) of things or options
  - Such lists must be MERGED. An override must be able to REMOVE items from a more global list (volume mount use case)
  - Such options be must be MERGED.An override must be able to un-sets options set from a more global list
- No need to specify at any given scope that some checks cannot be overridden in a more specific scope; those controls shall just be defined as non-negotiable by DevSecOps.
- Non-negotiable controls must be specified in the same git repo as the tenant ones and be generated too
- No need for different policies on different ACRs of a given tenant. Ruled out for design
  - Not needed with runtime policies, as zone scopes can be used instead
  - Most probably not needed with image assurance policies, as image name scopes can be used for exceptions

# Generated policies

- Non negotiable policies
  - global audit
  - global enforce
  - higher env enforce (and lower env audit)
  - lower env enforce (and higher env audit)
- Other policies, by stacking control definitions from more generic to more specific: default -> zone default -> tenant -> tenant zone -> tenant image
- Catch-all policy

# Change (approval) requirements

- Changes related to non-negotiable/default/zones must be approved by PDS
- Changes related to a tenant must be approved by the PO and PDS (likely the PDS chief security architect or delegates)

# Test requirements

## LaserPro

- Testing Linux/Windows parity for each control (or at least those which are supposed to be available on both OS)
- The testing plan should be documented (i.e. by leveraging the capability to enforce controls on lower envs only before enforcing them on higher envs)

# Audit requirements

- See what are the resulting controls, per tenant and env of all control definitions
