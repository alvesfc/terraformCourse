
resource "aws_ecr_repository" "aws-ecr" {
  name = lower("${var.app_name}-${var.infra_env}-ecr")

  tags = {
        Name        = "${var.project_name}-${var.infra_env}-ecr"
        Project     = var.project_name
        Environment = var.infra_env
        ManagedBy   = "terraform"
      }
}