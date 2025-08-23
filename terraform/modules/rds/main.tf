resource "aws_db_instance" "db" {
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  db_name               = var.db_name
  engine                = var.db_engine
  engine_version        = var.db_engine_version
  instance_class        = var.db_instance_class
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = var.db_parameter_group_name
  skip_final_snapshot   = var.db_skip_final_snapshot
  db_subnet_group_name  = aws_db_subnet_group.db_subnets.name
  publicly_accessible   = false
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "db-private-subnets"
  subnet_ids = var.private_subnet_ids
}