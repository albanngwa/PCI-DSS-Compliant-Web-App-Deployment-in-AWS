# configure aws profile
provider "aws" {
  region  = var.region
  profile = "alban"
}

# create vpc module

module "vpc" {
  source                       = "../modules/Vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}


# create security groups
module "security_groups" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.vpc_id

}


# create nat gateways

module "nat_gateway" {
  source                     = "../modules/nat-gateways"
  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id

}

# create ecs task execution role

module "ecs_task_execution_role" {
  source       = "../modules/ecs-task-execution-role"
  project_name = module.vpc.project_name
}

# create acm

module "acm" {
  source           = "../modules/acm"
  domain_name      = var.domain_name
  alternative_name = var.alternative_name
}

# create alb 

module "application_load_balancer" {
  source                = "../modules/alb"
  project_name          = module.vpc.project_name
  alb_security_group_id = module.security_groups.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.acm.certificate_arn
}


# create ecs
module "ecs" {
  source                       = "../modules/ecs"
  project_name                 = module.vpc.project_name
  ecs_tasks_execution_role_arn = module.ecs_task_execution_role.ecs_tasks_execution_role_arn
  container_image              = var.container_image
  region                       = module.vpc.region
  private_app_subnet_az1_id    = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id    = module.vpc.private_app_subnet_az2_id
  ecs_security_group_id        = module.security_groups.ecs_security_group_id
  aws_lb_target_group_arn      = module.application_load_balancer.aws_lb_target_group_arn
}

# create flow-logs-iam-role
module "flow-logs-iam-role" {
  source       = "../modules/vpc-flow-logs-role"
  project_name = module.vpc.project_name
}

# create vpc flog logs and cloudwatch log group
module "cloudwatch_log_group" {
  source                 = "../modules/cloudwatch-log-groups"
  project_name           = module.vpc.project_name
  retention_in_days      = var.retention_in_days
  vpc_id                 = module.vpc.vpc_id
  vpc_flow_logs_role_arn = module.flow-logs-iam-role.vpc_flow_logs_role_arn

}