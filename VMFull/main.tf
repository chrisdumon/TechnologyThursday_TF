terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.60.0"
    }
  }

  required_version = ">= 1.0.2"
}

provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "user_data" {
  template = file("./scripts/nginx.sh")
}

module "web_server_sg-http" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server-http"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.my-vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_instance" "webapp" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.web_server_sg-http.security_group_id]
  subnet_id = module.my-vpc.public_subnets[0]
  user_data = data.template_file.user_data.rendered
}

module "my-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


