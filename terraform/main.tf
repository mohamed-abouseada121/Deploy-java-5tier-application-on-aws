provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  az_1                  = var.az_1
  az_2                  = var.az_2
}

module "security_groups" {
  source = "./modules/security_groups"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  my_ip        = var.my_ip
}

module "rds" {
  source = "./modules/rds"

  project_name    = var.project_name
  private_subnets = module.vpc.private_subnets
  backend_sg_id   = module.security_groups.backend_sg_id
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password
}

module "elasticache" {
  source = "./modules/elasticache"

  project_name    = var.project_name
  private_subnets = module.vpc.private_subnets
  backend_sg_id   = module.security_groups.backend_sg_id
}

module "mq" {
  source = "./modules/mq"

  project_name    = var.project_name
  private_subnets = module.vpc.private_subnets
  backend_sg_id   = module.security_groups.backend_sg_id
  mq_username     = var.mq_username
  mq_password     = var.mq_password
}

module "ec2" {
  source = "./modules/ec2"

  project_name     = var.project_name
  public_subnet_id = module.vpc.public_subnet_id
  app_sg_id        = module.security_groups.app_sg_id
  public_key       = var.public_key
}

module "route53" {
  source = "./modules/route53"

  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  domain_name    = var.domain_name
  rds_endpoint   = module.rds.rds_endpoint
  cache_endpoint = module.elasticache.cache_endpoint
  mq_endpoint    = module.mq.mq_endpoint
}
