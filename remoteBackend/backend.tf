terraform {
  backend "s3" {
    bucket = "terraformstatebucket-20230125"
    key    = "backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformstatelock"
  }
}