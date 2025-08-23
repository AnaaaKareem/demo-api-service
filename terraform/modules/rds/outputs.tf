output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "db_username" {
  value = var.db_username
}

output "db_password" {
  value = var.db_password
}