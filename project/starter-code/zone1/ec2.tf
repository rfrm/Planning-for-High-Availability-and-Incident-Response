module "project_ec2" {
  source             = "./modules/ec2"
  instance_count     = var.instance_count
  name               = local.name
  account            = data.aws_caller_identity.current.account_id
  aws_ami            = "ami-0a0405f295e99e968"
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
  lb_group_arn       = module.alb.lb_group_arn
}
