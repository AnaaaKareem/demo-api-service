variable "private_subnets" {
  type = list(string)
}

variable "region" {
  type = string
  default = "eu-north-1"
}

variable "addons" {
  type = list(string)
  default = [ "vpc-cni", "kube-proxy", "aws-observability-collector" ]
}