# Provisioning Events

Our goal is to understand what Azure, AAD, Kubernetes, AzDO, GH, Tools, TFC, etc resources must be managed to support Fusion Operate provisioning events.

We also want to define the provisioning intent (e.g. new product, new app, app config change) as observable, discrete events to which we can clearly attach automation.

# Analysis Activities

For each event, analyze and capture across all FO domains and services

- What is the expected result (acceptance criteria) for the event? What should the tenant be able to do after each event?
- What is provisioned for each event (config, resource, identity, access, ...)?
- Where is provisioning automation managed today?
- Is anything manually provisioned, and why?
- What parameters are for product to control, what parameters are for platform to control?
- What is the pre-requisite state, provisioning dependencies for the event?
- Stretch (maybe pushed): What would reactive provisioning based on core API look like for the event? (based on control-plane interactions tab)

### Success Criteria

- Clearly define success criteria for each provisioning event across FO (what is the
- Design and backlog for how to consolidate provisioning automation today to improve tenant experience and alleviate FO scaling and toil pains
- Understand tomorrow how we will attach domain-specific automation to the FO Core Operator
- Clear definition of done for an FO service that includes participation in the provisioning automation
- Documentation captured and published in platformarchitecture-docs repo.

# Event List

## new product

#### Description

#### Examples

## change product

#### Description

#### Examples

- change quotas

## new team

#### Description

#### Examples

## new tier

#### Description

#### Examples

## new zone

#### Description

#### Examples

## new domain for product

#### Description

#### Examples

## new environment for product

#### Description

#### Examples

## product binding to zone

#### Description

#### Examples

## new product app

#### Description

#### Examples
