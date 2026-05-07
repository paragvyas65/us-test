resource "aquasec_container_runtime_policy" "nonNegociable-nonRevGen-ContainerRuntime-enforce" {
  name        = "nonNegociable-nonRevGen-ContainerRuntime-enforce"
  description = "..."
  enabled     = true
  enforce     = false
  application_scopes = [
    "Global",
  ]


  # Added due to rule common/container-runtime/driftPrevention.yaml
  enable_drift_prevention = true

  scope_expression = "v1 && (v2 || v3 || ...)"
  scope_variables {
    attribute = "image.name"
    value     = "*"
  }
  scope_variables {
    attribute = "kubernetes.cluster_name"
    value     = "zoneYYY" # found in LaserProCloud/assets/assets.yaml
  }
  scope_variables {
    attribute = "kubernetes.cluster_name"
    value     = "p21d11107025001" # found in common/assets/assets.yaml
  }
  scope_variables {
    attribute = "kubernetes.cluster_name"
    value     = "..."
  }
}
