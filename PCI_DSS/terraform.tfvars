
region                       = "us-east-2"
project_name                 = "pci-dss-vpc"
vpc_cidr                     = "10.0.0.0/16"
public_subnet_az1_cidr       = "10.0.0.0/24"
public_subnet_az2_cidr       = "10.0.1.0/24"
private_app_subnet_az1_cidr  = "10.0.2.0/24"
private_app_subnet_az2_cidr  = "10.0.3.0/24"
private_data_subnet_az1_cidr = "10.0.4.0/24"
private_data_subnet_az2_cidr = "10.0.5.0/24"
domain_name                  = "thengwa.xyz"
alternative_name             = "*.thengwa.xyz"
container_image              = "912290106707.dkr.ecr.us-east-2.amazonaws.com/pci-dss"
retention_in_days            = 7