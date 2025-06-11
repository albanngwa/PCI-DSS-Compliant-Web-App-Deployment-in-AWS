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
