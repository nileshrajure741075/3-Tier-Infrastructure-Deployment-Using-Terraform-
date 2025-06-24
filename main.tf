terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
 region = var.region
}

# key-pair
resource "aws_key_pair" "tf-key-pair" {
key_name = "tf-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}
 
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
 
resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "tf-key-pair"
}

module "vpc" {
  source = "./vpc"
}

module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
}

module "web" {
  source = "./web"
  ami_id = var.ami_id
  instance_type = var.ins_type
  sg_id = module.security.web_sg_id
  subnet_id = module.vpc.websubnet_id
}

module "app" {
  source = "./app"
  ami_id = var.ami_id
  instance_type = var.ins_type
  sg_id = module.security.app_sg_id
  subnet_id = module.vpc.appsubnet_id 
}

module "db" {
  source = "./db"
  sg_ids = module.security.db_sg_id
  db_subnet_group_name = module.vpc.dbsubnet_group_name
}
