resource "aws_instance" "app_server" {
  ami           = "ami-007868005aea67c54"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0bba0e320774a9ad3"
  tags = {
    Name = "WayneCorp"
  }
}