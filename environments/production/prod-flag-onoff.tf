# configure env-specific flag attributes on the ld_internal_tester flag in flags.tf
# requires the virtual_reality2 to be on to apply
resource "launchdarkly_feature_flag_environment" "test2" {
  flag_id           = "default/test2"
  env_key           = "production"
  targeting_enabled = false
}