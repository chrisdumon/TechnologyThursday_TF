terraform {
  required_providers {
    terraform = {
      source = "hashicorp/terraform"
      version = ">= 1.0.2"
    }
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.60.0"
    }
  }
}

provider "aws" {
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key
}
