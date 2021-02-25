
// Example Usage
resource "launchdarkly_feature_flag" "test1" {
  project_key = "default"
  key         = "virtual-test1"
  name        = "Virtual test1"
  description = "Note: Expects the user's organizations as an array of slugs"

  variation_type = "string"
  variations {
    value       = "true"
    name        = "true"
    description = "Enabling the feature flag"
  }
  variations {
    value       = "false"
    name        = "false"
    description = "Disabling the feature flag"
  }


  default_on_variation  = "true"
  default_off_variation = "false"

  tags = [
    "example",
    "terraform",
    "multivariate",
    "virtual-reality",
  ]
}