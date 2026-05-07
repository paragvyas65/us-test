resource "aquasec_container_runtime_policy" "catchAll-ContainerRuntime-enforce" {
  name        = "catchAll-ContainerRuntime-enforce"
  description = "..."
  enabled     = true
  enforce     = true
  application_scopes = [
    "Global",
  ]

  # not sure what the syntax is yet. This policy will call a custom script to just fail all the time
  custom_script = "exit 1"

  # This scope is defined as everything but all scopes specifically targetted by other policies
  scope_expression = "v1 && v2 && ! (...) && ! (...) && ! (...) ..."
  scope_variables {
    attribute = "image.name"
    value     = "*"
  }
  scope_variables {
    attribute = "kubernetes.cluster_name"
    value     = "*"
  }
  ...
}
