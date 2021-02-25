provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    region         = "us-west-2"
    bucket         = "dev-terraform-circleci-state"
    key            = "terraform.tfstate"
    dynamodb_table = "dev-terraform-lock"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

provider "launchdarkly" {
  version      = ">= 1.2.0"
  access_token = data.aws_kms_secrets.lauchdarkly_access_token.plaintext["access_token"]
}
################
# SSM Parameters
# Note: To generate the secret: `aws kms encrypt --key-id alias/sms --plaintext <text> --output text --query CiphertextBlob`
################

data "aws_kms_secrets" "access_token" {
  secret {
    name    = "access_token"
    payload = "AQICAHjWAmgDJv++j/wSoH0+nQj/g+A=="
  }
}