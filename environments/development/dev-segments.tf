//Example Usage
resource "launchdarkly_segment" "example" {
  key         = "test2"
  project_key = "default"
  env_key     = "development"
  name        = "example segment"
  description = "This segment is managed by Terraform"
  tags        = ["segment-tag-1", "segment-tag-2"]
  included    = ["user1", "user2"]
  excluded    = ["user3", "user4"]

  rules {
    clauses {
      attribute = "country"
      op        = "startsWith"
      values    = ["en", "de", "un"]
      negate    = false
    }
  }
}