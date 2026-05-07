resource "aquasec_container_runtime_policy" "zoneXXX-LaserProCloud-ContainerRuntime-enforce" {
  name        = "zoneXXX-LaserProCloud-ContainerRuntime-enforce"
  description = "..."
  enabled     = true
  enforce     = true
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

  # Added due to rule LaserProCloud/container-runtime/noRootUser.yaml
  only_none_root_users = true

  # Added due to rule LaserProCloud/container-runtime/CVESeverity.yaml
  custom_severity_enabled = true
  cvss_severity           = "high"
  cvss_severity_enabled   = true

  scope_expression = "v1 && v2"
  scope_variables {
    attribute = "image.name"
    value     = "*"
  }
  scope_variables {
    attribute = "kubernetes.cluster_name"
    value     = "zoneXXX"
  }
}
