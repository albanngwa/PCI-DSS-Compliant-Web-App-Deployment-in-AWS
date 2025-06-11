# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "ngwa-terraform-remote-states"
    key     = "pci_dss_state"
    region  = "us-east-2"
    profile = "alban"
  }
}