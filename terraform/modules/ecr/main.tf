resource "aws_ecr_repository" "node-app" {
  name                 = "node-app"
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = var.scan
  }
}