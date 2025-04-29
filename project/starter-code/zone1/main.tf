locals {
  account_id = data.aws_caller_identity.current.account_id

  name   = "udacity"
  region = "us-east-2"
  tags = {
    Name      = local.name
    Terraform = "true"
  }
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.100.0.0/16"

  account_owner = local.name
  name          = "${local.name}-project"
  azs           = ["us-east-2a", "us-east-2b"]
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  aws_instance_ids  = module.project_ec2.aws_instance_ids
}
