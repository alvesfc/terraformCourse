terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1"
}

variable "infra_env" {
  type        = string
  description = "Infrastructure environment"
  default     = "staging"

}

variable "project_name" {
  type        = string
  description = "The Project Name"
  default     = "myCompany"
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "appTest"
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile"
  default     = "cloudGuru"

}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  infra_env    = var.infra_env

  # Note we are /17, not /16
  # So we're only using half of the available
  vpc_cidr = "10.0.0.0/17"
}

#module "ecr" {
#  source = "./modules/ecr"
#
#  app_name     = var.app_name
#  project_name = var.project_name
#  infra_env    = var.infra_env
#
#}

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

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical official
}

module "ec2" {
  source = "./modules/ec2"

  project_name    = var.project_name
  infra_env       = var.infra_env
  infra_role      = "app"
  instance_size   = "t3.small"
  instance_ami    = data.aws_ami.ubuntu.id
  subnets         = keys(module.vpc.vpc_public_subnets)
  security_groups = [module.vpc.security_group_public]
  tags = {
    Name = "${var.project_name}-${var.infra_env}-app"
  }
}

module "ec2_worker" {
  source = "./modules/ec2"

  project_name              = var.project_name
  infra_env                 = var.infra_env
  infra_role                = "worker"
  instance_size             = "t3.small"
  instance_ami              = data.aws_ami.ubuntu.id
  instance_root_device_size = 50
  subnets                   = keys(module.vpc.vpc_private_subnets)
  security_groups           = [module.vpc.security_group_private]
  tags = {
    Name = "${var.project_name}-${var.infra_env}-worker"
  }

}


