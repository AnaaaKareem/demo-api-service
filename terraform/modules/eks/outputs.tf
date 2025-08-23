output "eks_name" {
  value = aws_eks_cluster.task-3-v2.name
}

output "kubeconfig" {
  value = null_resource.kubeconfig
}