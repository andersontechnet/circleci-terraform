# configure env-specific flag attributes on the ld_internal_tester flag in flags.tf
# requires the virtual_reality2 to be on to apply
resource "launchdarkly_feature_flag_environment" "virtual_reality2" {
  flag_id           = "default/virtual-reality2"
  env_key           = "staging"
  targeting_enabled = true
}
