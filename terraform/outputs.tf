output "db_uname" {
  value     = module.rds.db_username
  sensitive = true
}

output "db_pass" {
  value     = module.rds.db_password
  sensitive = true
}

output "node_app_name" {
  value = module.ecr.node-name
}

output "cluster_name" {
  value = module.eks.eks_name
}

output "db_endpoint" {
  value = module.rds.rds_endpoint
}