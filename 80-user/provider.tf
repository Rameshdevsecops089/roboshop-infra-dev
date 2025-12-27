terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.22.0"
    }
  }

  backend "s3" {
    bucket = "84s-remote-state-dev1"
    key    = "roboshop-dev-user"
    region = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}