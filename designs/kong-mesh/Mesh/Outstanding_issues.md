# Open Issues

## Network-attachment-definitions

### Description

When enabling the Mesh on a deployment instead of namespace, the Network-attachment-definition is not created causing the sidecars to fail to be created.

### Status

Open Github Issue with Kong

https://github.com/kumahq/kuma/issues/4224

Internal JIRA

https://jira.finastra.com/browse/FO-12790

### Workaround

Disable the mesh configuration on any deployments that are not going to be on the mesh, then add the label to the namespace configuration

## Unable to get external traffic onto the mesh

### Description

External traffic coming into the mesh needs to pass thru a Gateway to use services on the mesh. The current design is to have the Openshift Router act as the ingress into the cluster which would then also be the Gateway. To pass traffic to the services on the mesh, the Ingress would need to be configured with the mesh service FQDN as an external service name. Currently the Openshift Router is not able to pickup and use an external service as the backend on the Router.

### Status

Kong has discussed and validated this issue with Red Hat. Kong has a ticket open with Red Hat and there is a public backlog item.

https://issues.redhat.com/browse/RFE-2832

JIRA

https://jira.finastra.com/browse/FO-12356

### Workaround

1. Validated that the Kong Kubernetes Ingress Controller (KIC) is able to be deployed onto Openshift to act as the Ingress. Tested both same Zone and multi-Zone traffic passing thru the Ingress without issue.

1. Tested the standalone MeshGateway which was released in 1.6 as an experimental feature. Unable to create service with an annotation to use an internal Azure LB. Capability was released as part of 1.7, however did not have time to revisit.
