# Zone Configuration

## Description

Kong is available as either a single zone or multi-zone configuration. Zones organize how the underlying infrastructure is divided up, while a Mesh is defined higher up in the stack.

## Decision

**Multi-Zone**

Each Tier (Internal/Platform) would have it's own MultiZone mesh deployment with the Global Control Plane being created in the Management Zone for that tier. This provides a centralized location for all the regional zones to check into. The Management Zone also will not have Tenant applications requiring a Mesh running on it meeting the Kong requirement.

## Comparisons

#### Single Zone

**Pro's**

- Reduced complexity when traffic is moving between clusters with no need for a Zone Ingress

**Con's**

- Requires direct connectivity between all data plane's
- No locality aware DNS (traffic could be sent to any active data plane pod for that service regardless of region)

#### Multi Zone

**Pros's**

- Locality aware DNS to keep traffic within the boundaries of the Zone
- No requirement to join clusters together at the network level

**Cons's**

- Centralized Control Plane is required on a cluster that does not participate in any Mesh configuration
