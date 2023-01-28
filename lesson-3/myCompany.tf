terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  infra_env    = var.infra_env

  # Note we are /17, not /16
  # So we're only using half of the available
  vpc_cidr = "10.0.0.0/17"
}

module "ecr" {
  source = "./modules/ecr"

  app_name     = var.app_name
  project_name = var.project_name
  infra_env    = var.infra_env

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
}
