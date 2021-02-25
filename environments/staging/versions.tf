provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    region         = "us-west-2"
    bucket         = "staging-terraform-circleci-state"
    key            = "terraform.tfstate"
    dynamodb_table = "staging-terraform-circleci-state-lock"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

provider "launchdarkly" {
  version      = ">= 1.2.0"
  access_token = data.aws_kms_secrets.lauchdarkly_access_token.plaintext["lauchdarkly_access_token"]
}
################
# SSM Parameters
# Note: To generate the secret: `aws kms encrypt --key-id alias/nomad-env --plaintext <text> --output text --query CiphertextBlob`
################

data "aws_kms_secrets" "lauchdarkly_access_token" {
  secret {
    name    = "lauchdarkly_access_token"
    payload = "AQICAHhFE4kAOXgemgUB2QJYYcGmD9aJR+TmVFkUwkNzlpU9nwFUoez6SOQidwF7qV3a8OpIAAAAhzCBhAYJKoZIhvcNAQcGoHcwdQIBADBwBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDEGVHKnA9PC1K/G0CAIBEIBDs9X43AXdYzUJvR/5ytGUhilAtvWLUHtmKNzvW235bXjfF6Woy/hw7B5ViG63sTeQnPhgLw7FaDzLbNaD3wn6gN8ZoA=="
  }
}