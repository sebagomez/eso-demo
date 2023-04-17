terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.63.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # I'm using my local ~/.aws/credentials file
#   access_key = "my-access-key"
#   secret_key = "my-secret-key"
}