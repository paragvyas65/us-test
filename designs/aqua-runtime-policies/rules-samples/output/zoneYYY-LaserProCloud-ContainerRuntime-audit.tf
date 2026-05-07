resource "aquasec_container_runtime_policy" "zoneYYY-LaserProCloud-ContainerRuntime-audit" {
  name        = "zoneYYY-LaserProCloud-ContainerRuntime-audit"
  description = "..."
  enabled     = true
  enforce     = false
  application_scopes = [
    aquasec_application_scope.LaserProCloud.name,
  ]

  # Added due to rule common/container-runtime/blockVolumes.yaml
  #        and LaserProCLoud/container-runtime/blockVolumes.yaml
  blocked_volumes = [
    # These lines are added by common/container-runtime/blockVolumes.yaml
    "/",
    "/bin",
    "/boot",
    "/etc",
    "/slib",
    # This line is added by LaserProCLoud/container-runtime/blockVolumes.yaml
    "/exe",
    # This line is removed by LaserProCLoud/container-runtime/blockVolumes.yaml
    # "/lib",
  ]

  scope_expression = "v1 && v2"
  scope_variables {
    attribute = "image.name"
    value     = "*"
  }
  scope_variables {
    attribute = "kubernetes.cluster_name"
    value     = "zoneYYY"
  }
}
