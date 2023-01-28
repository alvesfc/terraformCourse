


variable "infra_env" {
    type        = string
    description = "Infrastructure environment"
}

variable "security_groups" {
    type        = list(string)
    description = "Infrastructure environment"
}

variable "subnets" {
  type        = list(string)
  description = "Infrastructure environment"
}

variable "tags" {
  type        = map
  description = "Infrastructure environment"
}

variable "project_name" {
  type        = string
  description = "The Project Name"
}

variable infra_role {
  type = string
  description = "infrastructure purpose"
}

variable instance_size {
  type = string
  description = "ec2 web server size"
  default = "t3.small"
}

variable instance_ami {
  type = string
  description = "Server image to use"
}

variable instance_root_device_size {
  type = number
  description = "Root bock device size in GB"
  default = 12
}