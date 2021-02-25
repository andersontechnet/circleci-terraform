provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    region         = "us-west-2"
    bucket         = "prod-terraform-circleci-state"
    key            = "terraform.tfstate"
    dynamodb_table = "prod-terraform-circleci-state-lock"
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
    payload = "AQICAHiNG6xU2B6uh0gfyHmkrSusbvg9nSLTRWx+XRktFjZ+SwFNR/m2l6RiVmZmLyWvh9LPAAAAhzCBhAYJKoZIhvcNAQcGoHcwdQIBADBwBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDLm0kdQQ5Gk3KqE65gIBEIBD4uorwI0cpn9P4HIzsKcD3YvIThRe+cu5P3B/mv14bFA9taldiAdKwbIvW2S6uXUVmwYVcJxQDty+AhIjshjTACmQmw=="
  }
}