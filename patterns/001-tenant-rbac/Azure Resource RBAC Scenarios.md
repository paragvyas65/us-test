# Azure RBAC Scenarios

## Azure AD RBAC

### FusionOperate Security Group

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor FusionOperate security group configuration  
   **So that** I can understand current FusionOperate security group deployment and understand current role assignment of FusionOperate team members  

1. **As** a FusionOperate product owner  
   **I need** the ability to manage FusionOperate security group configuration using least privilege (PIM)  
   **So that** I can manage FusionOperate security group assignment of team members in a secure manner  

1. **As** a FusionOperate product owner  
   **I need** the ability to configure PIM notification and view PIM audit logging for FusionOperate security groups  
   **So that** I can be alerted to FusionOperate PIM requests and audit FusionOperate PIM activity  

### Product Security Group

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor Product security group configuration  
   **So that** I can assist with troubleshooting Product security group configuration and understand current role assignment of Product team members  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product security group configuration  
   **So that** I can understand current Product security group deployment and understand current role assignment of Product team members  

1. **As** a Product product owner  
   **I need** the ability to manage Product security group configuration using least privilege (PIM)  
   **So that** I can manage Product security group assignment of team members in a secure manner  

1. **As** a Product product owner  
   **I need** the ability to configure PIM notification and view PIM audit logging for Product security groups  
   **So that** I can be alerted to Product PIM requests and audit Product PIM activity  

## Azure Resource Management RBAC (control plane)

### FusionOperate Azure Resources

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor FusionOperate Azure resource configuration  
   **So that** I can understand current FusionOperate Azure resource configuration to assist with troubleshooting FusionOperate Azure resources  

1. **As** a member of the FusionOperate team  
   **I need** the ability to raise support tickets for FusionOperate Azure resources  
   **So that** I can get Microsoft troubleshooting support for deployed FusionOperate Azure resources  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage FusionOperate Azure resource configuration using least privilege (PIM)  
   **So that** I can update legacy FusionOperate Azure resource configuration not managed by terraform in a secure manner  
   **And so that** I can update terraform-managed FusionOperate Azure resource configuration in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor FusionOperate Azure resource configuration  
   **So that** I can understand current FusionOperate Azure resource configuration when troubleshooting an issue  

### Product Azure Resources 

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor Product Azure resource configuration  
   **So that** I can understand current Product Azure resource configuration to assist with troubleshooting an issue  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product Azure resource configuration  
   **So that** I can understand current Product Azure resource configuration to assist with troubleshooting Product Azure resources  

1. **As** a member of a Product team  
   **I need** the ability to raise support tickets for Product Azure resources  
   **So that** I can get Microsoft troubleshooting support for deployed Product Azure resources  

1. **As** a member of a Product team  
   **I need** the ability to manage Product Azure resource configuration using least privilege (PIM)  
   **So that** I can update non-terraform-managed Product Azure resource configuration in a secure manner  
   **And so that** I can update terraform-managed Product Azure resource configuration in an emergency situation in a secure manner  

### Product Zone-Bound Azure Resources (cluster nodepools, cluster loadbalancers, etc.)

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor Product zone-bound Azure resource configuration  
   **So that** I can understand current Product zone-bound Azure resource configuration to assist with toubleshooting issue(s)  

1. **As** a member of the FusionOperate team  
   **I need** the ability to raise support tickets for Product zone-bound Azure resources  
   **So that** I can get Microsoft troubleshooting support for deployed Product zone-bound Azure resources  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage Product zone-bound Azure resource configuration using least privilege (PIM), because Product zone-bound Azure resources are tightly coupled to FusionOperate managed Azure resources  
   **So that** I can update / perform maintenance on non-terraform-managed Product zone-bound Azure resource configuration in a secure manner 
   **And so that** I can update / perform maintenance on terraform-managed Product zone-bound Azure resource configuration in an emergency situation in a secure manner 

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product zone-bound Azure resource configuration  
   **So that** I can understand current Product zone-bound Azure resource configuration to assist with troubleshooting Product zone-bound Azure resources  

1. **As** a member of a Product team  
   **I need** the ability to raise support tickets for Product zone-bound Azure resources  
   **So that** I can get Microsoft troubleshooting support for deployed Product zone-bound Azure resources  

1. **As** a member of a Product team  
   **I need** the ability to manage Product zone-bound Azure resource configuration using least privilege (PIM)  
   **So that** I can update non-terraform-managed Product zone-bound Azure resource configuration in a secure manner  
   **And so that** I can update terraform-managed Product zone-bound Azure resource configuration in an emergency situation in a secure manner  

## Azure Resource RBAC (data plane)

### Azure Kubernetes Cluster

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor zone k8s resource(s) in scoped namespace(s) (execing into zone pods disallowed)  
   **So that** I can understand currently deployed zone k8s resource(s) to assist with troubleshooting FusionOperate k8s services  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage zone k8s resource(s) in scoped namespace(s) using least privilege (PIM)  
   **So that** I can update flux-managed zone k8s resource(s) in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor zone k8s resource(s) in scoped namespace(s) (except for viewing of secret content and execing into zone pods)  
   **So that** I can understand currently deployed zone k8s resource(s) to assist with troubleshooting issue(s)  

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor Product k8s resource(s) in scoped namespace(s) (except for viewing of secret content and execing into Product pods)  
   **So that** I can understand currently deployed k8s resource(s) to assist with troubleshooting cluster issue(s)  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product k8s resource(s) in scoped namespace(s) (execing into Product pods disallowed)  
   **So that** I can understand currently deployed Product k8s resrouce(s) to assist in troubleshooting issue(s)  

1. **As** a member of a Product team  
   **I need** the ability to manage Product k8s resource(s) in scoped namespace(s) using least privilege (PIM)  
   **So that** I can update flux-managed zone k8s resource(s) in an emergency situation in a secure manner  

### Azure Keyvaults

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor FusionOperate Azure Keyvault keys, certificates, secrets  
   **So that** I can troubleshoot issues related to FusionOperate Azure Keyvault data  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage FusionOperate Azure Keyvault kesy, certificates, secrets using least privilege (PIM)  
   **So that** I can update non-terraform-managed FusionOperate Azure Keyvault data in a secure manner  
   **And so that** I can update terraform-managed FusionOperate Azure Keyvault data in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor FusionOperate Azure Keyvault keys, certificates, secrets (except for value/content viewing)  
   **So that** I can troubleshoot issues related to FusionOperate Azure Keyvault data  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product Azure Keyvault keys, certificates, secrets  
   **So that** I can troubleshoot issues related to Product Azure Keyvault data  

1. **As** a member of a Product team  
   **I need** the ability to manage Product Azure Keyvault keys, certificates, secrets using least privilege (PIM)  
   **So that** I can update non-terraform-managed Product Azure Kevyault data in a secure manner  
   **And so that** I can update terraform-managed Product Azure Keyvault data in an emergency situation in a secure manner  

### Azure Storage Accounts

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor FusionOperate Azure Storage Account data  
   **So that** I can troubleshoot issues related to FusionOperate Azure Storage Account data  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage FusionOperate Azure Storage Account data using least privilege (PIM)  
   **So that** I can update non-terraform-managed FusionOperate Azure Storage Account data in a secure manner  
   **And so that** I can update terraform-managed FusionOperate Azure Storage Account data in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor FusionOperate Azure Storage Account data (except for value/content viewing)  
   **So that** I can troubleshoot issues related to FusionOperate Azure Storage Account data  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product Azure Storage Account data  
   **So that** I can troubleshoot issues related to Product Azure Storage Account data  

1. **As** a member of a Product team  
   **I need** the ability to manage Product Azure Storage Account data using least privilege (PIM)  
   **So that** I can update non-terraform-managed Product Azure Storage Account data in a secure manner  
   **And so that** I can update terraform-managed Product Azure Storage Account data in an emergency situation in a secure manner  

### Azure Container Registries

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor FusionOperate Azure Container Registry data  
   **So that** I can troubleshoot issues related to FusionOperate Azure Container Registry data  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage FusionOperate Azure Container Registry data using least privilege (PIM)  
   **So that** I can update non-terraform-managed FusionOperate Azure Container Registry data in a secure manner  
   **And so that** I can update terraform-managed FusionOperate Azure Container Registry data in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor FusionOperate Azure Container Registry data  
   **So that** I can troubleshoot issues related to FusionOperate Azure Container Registry data  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product Azure Container Registry data  
   **So that** I can troubleshoot issues related to Product Azure Container Registry data  

1. **As** a member of a Product team  
   **I need** the ability to manage Product Azure Container Registry data using least privilege (PIM)  
   **So that** I can update non-terraform-managed Product Azure Container Registry data in a secure manner  
   **And so that** I can update terraform-managed Product Azure Container Registry data in an emergency situation in a secure manner  

### Azure Log Analytics Workspaces

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor data logged to a FusionOperate Azure Log Analytics workspace  
   **So that** I can troubleshoot issues related to resources logging to the FusionOperate Azure Log Analytics workspace

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product scoped data logged to a FusionOperate Azure Log Analytics workspace  
   **So that** I can troubleshoot issues related to resources logging to the FusionOperate Azure Log Analytics workspace  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor data logged to a Product Azure Log Analytics workspace  
   **So that** I can troubleshoot issues related to resources logging to the Product Azure Log Analytics workspace  

### Legacy Pipeline Resources Infrastructure

> The following scenarios are required for management of legacy FusionOperate Azure resources.
>
> Once these legacy FusionOperate Azure resources are migrated to Product resources, these scenarios are no longer required.

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor FO-managed Test Platform Storage Account Product data (except for value/content viewing)  
   **So that** I can troubleshoot issues related to the FO-managed Test Platform Storage Account  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage FO-managed Test Platform Storage Account Product data using least privilege (PIM)  
   **So that** I can maintain FO-managed Test Platform Storage Account data performance in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor FO-managed Test Platform Storage Account Product data  
   **So that** I can manage FO-managed Test Platform Storage Account Product data  

1. **As** a member of a Product team  
   **I need** the ability to manage FO-managed Test Platform Storage Account Product data using least privilege (PIM)  
   **So that** I can remove FO-managed Test Platform Storage Account Product data in an emergency situation in a secure manner  

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / monitor FO-managed Azure Container Registry Product data  
   **So that** I can troubleshoot issues related to the FO-managed Azure Container Registry  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage FO-managed Azure Container Registry Product data using least privilege (PIM)  
   **So that** I can maintain FO-managed Azure Container Registry performance in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / monitor FO-managed Azure Container Registry Product data  
   **So that** I can manage FO-managed Azure Container Registry Product data  

1. **As** a member of a Product team  
   **I need** the ability to manage FO-managed Azure Container Registry Product data using least privilege (PIM)  
   **So that** I can manage FO-managed Azure Container Registry Product data in an emergency situation in a secure manner  

## Resource RBAC (leveraging Azure AD)

### Aqua Console

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / explore Aqua console data / configuration  
   **So that** I can troubleshoot Aqua issues  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage Aqua console data / configuration using least privilege (PIM)  
   **So that** I can resolve Aqua issues in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / explore scoped Aqua console data / configuration  
   **So that** I can troubleshoot security issues identified by Aqua  

### Grafana Cloud Stack

1. **As** a member of the FusionOperate team  
   **I need** the ability to view / explore FusionOperate Grafana Cloud stack data / configuration  
   **So that** I can effectively monitor FusionOperate resources reporting to the FusionOperate Grafana Cloud stack(s)  

1. **As** a member of the FusionOperate team  
   **I need** the ability to manage FusionOperate Grafana Cloud stack data / configuration using least privilege (PIM)  
   **So that** I can address FusionOperate Grafana Cloud stack data / configuration issues in an emergency situation in a secure manner  

1. **As** a member of a Product team  
   **I need** the ability to view / explore Product Grafana Cloud stack data / configuration  
   **So that** I can effectively monitor Product resources reporting to the Product Grafana Cloud stack(s)  

1. **As** a member of a Product team  
   **I need** the ability to manage Product Grafana Cloud stack data / configuration using least privilege (PIM)  
   **So that** I can address Product Grafana Cloud stack data / configuration issues in an emergency situation in a secure manner  

### Atlas DB

1. **As** a member of a Product team  
   **I need** the ability to view / monitor Product Atlas DB data / configuration  
   **So that** I can troubleshoot Product issues  

1. **As** a member of a Product team  
   **I need** the ability to manage Product Atlas DB data / configuration using least privilege (PIM)  
   **So that** I can resolve Atlas DB data issues in an emergency situation in a secure manner  
