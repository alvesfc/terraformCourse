resource "aws_instance" "web_app" {
  ami           = var.instance_ami
  instance_type = var.instance_size

  vpc_security_group_ids = var.security_groups
  subnet_id =  random_shuffle.subnets.result[0]

  root_block_device {
    volume_size = var.instance_root_device_size
    volume_type = "gp3"
  }

  tags = merge({
    Name        = "${var.project_name}-${var.infra_env}-vpc"
    Project     = var.project_name
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Role        = var.infra_role
  },
    var.tags
  )
}

resource "aws_eip" "app_addr" {
  # We're not doing this directly
  # instance = aws_instance.web_app.id
  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = merge({
    Name        = "${var.project_name}-${var.infra_env}-vpc"
    Project     = var.project_name
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Role        = var.infra_role
  },
    var.tags
  )
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web_app.id
  allocation_id = aws_eip.app_addr.id
}

resource "random_shuffle" "subnets" {
  input        = var.subnets
  result_count = 1
}