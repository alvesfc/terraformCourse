output "app_eip" {
  value = aws_eip.app_addr.public_ip
}

output "app_instance" {
  value = aws_instance.web_app.id
}