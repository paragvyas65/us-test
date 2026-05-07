resource "aquasec_container_runtime_policy" "nonNegociable-ContainerRuntime-enforce" {
  name        = "nonNegociable-ContainerRuntime-enforce"
  description = "..."
  enabled     = true
  enforce     = true
  application_scopes = [
    "Global",
  ]


  # Added due to rule common/container-runtime/blockCryptoMining.yaml
  block_cryptocurrency_mining = true

  scope_expression = "v1 && v2"
  scope_variables {
    attribute = "image.name"
    value     = "*"
  }
  scope_variables {
    attribute = "kubernetes.cluster_name"
    value     = "*"
  }
}
