module "vpc" {
  source = "./modules/vpc"
}

module "rds" {
  source             = "./modules/rds"
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "eks" {
  source          = "./modules/eks"
  private_subnets = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"
}


terraform {
  backend "s3" {
    bucket         = "tfk-state"
    key            = "./task3/2/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks-2"
    use_lockfile   = true
    encrypt        = true
  }
}