variable tenancy_ocid {}
variable user_ocid {}
variable fingerprint {}
variable private_key_path {}
variable region {}
variable ssh_public_key {}

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

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = "ocid1.compartment.oc1..aaaaaaaa2msdfh2g3n4s6fadsvl2thelw5gtnwhbcsqwcgfg2hcsk7mjc3ya"
    shape = "VM.Standard2.2"
    display_name = "RD-TEST-02"

    create_vnic_details {
        #Required
        subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaal4cvjywvkqlmsoz7x2gfs73zcx2xdfddrbboyp5gcdpp33vxcxaa"
    }
    metadata = {
        ssh_authorized_keys = var.ssh_public_key
    }
    source_details {
        #Required
        source_id = "ocid1.image.oc1.iad.aaaaaaaawufnve5jxze4xf7orejupw5iq3pms6cuadzjc7klojix6vmk42va"
        source_type = "image"
    }
    preserve_boot_volume = false
}