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
  config_file_profile= var.oci_config_file_profile
  region = var.region
}