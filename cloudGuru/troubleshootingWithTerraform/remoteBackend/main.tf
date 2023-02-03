
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

provider "aws" {
  profile = "cloudGuru"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t3.micro"
  subnet_id = "subnet-02fe7205964142f5b"

  tags = {
    name = "app_server"
  }
}