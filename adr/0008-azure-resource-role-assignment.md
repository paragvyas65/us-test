## Status

status: proposed\
date: 2024-01-31\

---

## ADR-0008 Azure Resource Role Assignment

### Context and Problem Statement

The process of managing Azure resource access control has not been well defined for some time and requires some clarification around which teams
(FusionOperate, Product team, both?) are responsible for Azure resource role assignment.

### Decision Drivers

- Determine which teams (FusionOperate, Product team, both?) are responsible for managing Azure resource role assignment.
- Determine what role(s) should be available for Azure resource role assignment

### Considered Options

- FusionOperate manages role assignments for __all__ Azure resources (both FusionOperate and Product Azure resources)  
  FusionOperate identifies standard roles for __all__ Azure resource role assignment
- FusionOperate manages role assignments for __all__ Azure resources (both FusionOperate and Product Azure resources)  
  Standard and custom roles allowed for  __all__ Azure resource role assignment
- FusionOperate manages role assignments for FusionOperate Azure resources only  
  FusionOperate identifies standard roles for FusionOperate Azure resource role assignment  
  Product teams manage role assignments for their own Azure resources
- FusionOperate manages role assignments for FusionOperate Azure resources only  
  Standard and custom roles allowed for FusionOperate Azure resource role assignment  
  Product teams manage role assignments for their own Azure resources
  
### Decision Outcome

Option 4 was selected.

FusionOperate manages role assignments for FusionOperate Azure resources only.  FusionOperate identifies standard roles for FusionOperate
Azure resource role assignment, while allowing custom roles to also be assigned to FusionOperate Azure resources.  Product teams manage role
assignments for their own Azure resources.

#### Consequences

- Good, because Product teams don't need to worry about managing role assignment for FusionOperate Azure resources
- Good, because a catalog of roles that can be assigned to FusionOperate Azure resources is pre-defined and can be selected a-la-carte
- Good, because FusionOperate is able to define custom roles (if desired) that can be used in FusionOperate Azure resource role assignment
- Good, because FusionOperate doesn't need to worry about managing role assignment for Product Azure resources
- Neutral, because Product teams still have to manage (manually or via automation) role assignment for Product Azure resources
- Neutral, because Product teams have to identify their own desired roles / permissions for Product Azure resources
- Neutral, because service principals allowed role assignment have to be created / maintained by FusionOperate
- Netural, because the responsibility of maintaining FusionOperate Azure resource role assignment automation lies on FusionOperate

### Pros and Cons of the Options

__FusionOperate manages role assignments for __all__ Azure resources (both FusionOperate and Product Azure resources)__  
__FusionOperate identifies standard roles for __all__ Azure resource role assignment__

This proposal suggests FusionOperate will manage role assignments for __all__ deployed Azure resources (both FusionOperate and Product Azure resources).
The set of roles that can be assigned will be pre-defined by FusionOperate and will be a static set of roles (probably based on resource type).

- Good, because Product teams don't need to worry about managing role assignment; they only need to identify security principals and scoope to have roles
  assigned to
- Good, because a catalog of roles that can be assigned is pre-defined and can be selected a-la-carte by teams
- Neutral, because service principals allowed role assignment have to be created / maintained by FusionOperate
- Neutral, because roles that can be assigned are limited to that identified as `standard` roles by FusionOperate
- Bad, because service principals used for role assignment have to be able to manage role assignments for __all__ deployed Azure resource (breaking
  the rule of least privilege)
- Bad, because identified roles may not be as granular (permission-wise) as a team requires
- Bad, because the responsibility of identifying standard Azure resource roles lies on FusionOperate
- Bad, because the responsibility of maintaining Azure resource role assignment automation lies on FusionOperate
- Bad, because FusionOperate would need to create the guardrails to only allow its role assignments

__FusionOperate manages role assignments for __all__ Azure resources (both FusionOperate and Product Azure resources)__  
__Standard and custom roles allowed for  __all__ Azure resource role assignment__

This proposal suggests FusionOperate will manage role assignments for __all__ deployed Azure resources (both FusionOperate and Product Azure resources).
A standard set of roles that can be assigned will be pre-defined by FusionOperate, yet custom roles may also be specified for Azure resource role assignment.

- Good, because Product teams don't need to worry about managing role assignment; they only need to identify security principals and scoope to have roles
  assigned to
- Good, because a catalog of roles that can be assigned is pre-defined and can be selected a-la-carte by teams
- Good, because teams are able to define their own custom roles (if desired) that can be used in role assignment
- Neutral, because service principals allowed role assignment have to be created / maintained by FusionOperate
- Bad, because service principals used for role assignment have to be able to manage role assignments for __all__ deployed Azure resource (breaking
  the rule of least privilege)
- Bad, because the responsibility of identifying standard Azure resource roles lies on FusionOperate
- Bad, because the responsibility of maintaining Azure resource role assignment automation lies on FusionOperate
- Bad, because FusionOperate would need to create the guardrails to only allow its role assignments

__FusionOperate manages role assignments for FusionOperate Azure resources only__  
__FusionOperate identifies standard roles for FusionOperate Azure resource role assignment__  
__Product teams manage role assignments for their own Azure resources__

This proposal suggests FusionOperate will manage role assignments for FusionOperate Azure resources only while leaving role assignment for Product
Azure resources up to the Product team.  The set of roles that can be assigned to FusionOperate Azure resources will be pre-defined by FusionOperate
and will be a static set of roles (probably based on resource type).

- Good, because Product teams don't need to worry about managing role assignment for FusionOperate Azure resources
- Good, because a catalog of roles that can be assigned to FusionOperate Azure resources is pre-defined and can be selected a-la-carte
- Good, because FusionOperate doesn't need to worry about managing role assignment for Product Azure resources
- Neutral, because Producte teams still have to manage (manually or via automation) role assignment for Product Azure resources
- Neutral, because Product teams have to identify their own desired roles / permissions for Product Azure resources
- Neutral, because service principals allowed role assignment have to be created / maintained by FusionOperate
- Netural, because the responsibility of maintaining FusionOperate Azure resource role assignment automation lies on FusionOperate
- Neutral, because roles that can be assigned to FusionOperate Azure resources are limited to that identified as `standard` roles by FusionOperate
- Bad, because identified roles for FusionOperate Azure resource role assignment may not be as granular (permission-wise) as required

__FusionOperate manages role assignments for FusionOperate Azure resources only__  
__Standard and custom roles allowed for FusionOperate Azure resource role assignment__  
__Product teams manage role assignments for their own Azure resources__

This proposal suggests FusionOperate will manage role assignments for FusionOperate Azure resources only while leaving role assignment for Product
Azure resources up to the Product team.  A standard set of roles that can be assigned to FusionOperate Azure resources will be pre-defined by
FusionOperate, yet custom roles may also be specified for FusionOperate Azure resource role assignment.

- Good, because Product teams don't need to worry about managing role assignment for FusionOperate Azure resources
- Good, because a catalog of roles that can be assigned to FusionOperate Azure resources is pre-defined and can be selected a-la-carte
- Good, because FusionOperate is able to define custom roles (if desired) that can be used in FusionOperate Azure resource role assignment
- Good, because FusionOperate doesn't need to worry about managing role assignment for Product Azure resources
- Neutral, because Producte teams still have to manage (manually or via automation) role assignment for Product Azure resources
- Neutral, because Product teams have to identify their own desired roles / permissions for Product Azure resources
- Neutral, because service principals allowed role assignment have to be created / maintained by FusionOperate
- Netural, because the responsibility of maintaining FusionOperate Azure resource role assignment automation lies on FusionOperate

### More Information

More information about Azure resource access control can be found [here](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview).

Information about Azure role assignment automation using terraform can be found [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)
