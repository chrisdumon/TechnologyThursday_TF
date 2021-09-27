terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.60.0"
    }
  }

  required_version = ">= 1.0.2"
}

provider "aws" {
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key
}
