terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
      #version = "3.93.0"
    }
  }
}

provider "oci" {
  # Configuration options
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key_path = var.private_key_path
  #auth = "InstancePrincipal"
  region = var.region
}