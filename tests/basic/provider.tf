terraform {
  required_version = ">=0.15"

  backend "s3" {
    bucket = "softcat-terraform"
    key    = "gcp/vpc-module/terraform.tfstate"
    region = "eu-west-2"
  }
  required_providers {
    aws = {
      version = ">= 3.20"
      source  = "hashicorp/aws"
    }

    google = {
      version = ">= 3"
      source  = "hashicorp/google"
    }
    google-beta = {
      version = ">= 3"
      source  = "hashicorp/google-beta"
    }
  }
}