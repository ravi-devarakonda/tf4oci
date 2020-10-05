#auth variables
variable tenancy_ocid {}
variable user_ocid {}
variable fingerprint {}
variable private_key_path {}
variable region {}

#env variables
variable compartment_id {}
variable image_id {}
variable subnet_id {}

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
  region = var.region
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.compartment_id
    shape = "VM.Standard2.1"
    display_name = "RD-TEST-02"

    create_vnic_details {
        #Required
        subnet_id = var.subnet_id
    }
    metadata = {
        ssh_authorized_keys = file("/home/opc/.ssh/id_rsa.pub")
    }
    source_details {
        #Required
        source_id = var.image_id
        source_type = "image"
    }
    preserve_boot_volume = false
}