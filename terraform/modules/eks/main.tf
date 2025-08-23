resource "aws_eks_cluster" "task-3-v2" {
  name = "Task-Three-v2"
  role_arn = aws_iam_role.cluster.arn
  version = "1.33"

  access_config {
    authentication_mode = "API"
  }

  upgrade_policy {
    support_type = "STANDARD"
  }

  vpc_config {
    subnet_ids = var.private_subnets
    
    # security_group_ids = 
    endpoint_public_access = true
    endpoint_private_access = true
  }

  zonal_shift_config {
    enabled = false
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig ${var.region} --name ${aws_eks_cluster.task-3-v2.name}" 
  }

  depends_on = [ aws_eks_cluster.task-3-v2 ]
}

resource "aws_eks_addon" "addons" {
  for_each = toset(var.addons)

  cluster_name = aws_eks_cluster.task-3-v2.name
  addon_name   = each.value
}

resource "aws_eks_node_group" "eks-node" {
  cluster_name = aws_eks_cluster.task-3-v2.name
  node_group_name = "node"
  node_role_arn = aws_iam_role.node.arn
  subnet_ids = var.private_subnets
  instance_types = [ "t3.small" ]

  scaling_config {
    desired_size = 2
    min_size = 2
    max_size = 3
  }

  update_config {
    max_unavailable = 1
  }
}

resource "aws_iam_role" "node" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-karim"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}