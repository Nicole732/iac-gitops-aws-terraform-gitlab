terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.3"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  #profile = var.aws_profile
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  default_tags {
    tags = {
      environment = var.env_prefix
      terraform   = "true"
    }
  }
}