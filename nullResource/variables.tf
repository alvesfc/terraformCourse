variable "instance_ami" {
  description = "Value of the AMI used for the EC2 instance"
  type        = string
  default     = "ami-007868005aea67c54"
}

variable "subnet_id" {
  description = "Value of the subnet id used for the EC2 instance"
  type        = string
  default     = "subnet-07fce84e9b5d4169a"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "TheFastestManAlive"
}
