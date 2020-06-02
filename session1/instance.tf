variable tenancy_ocid {}

variable ssh_public_key {}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = ""
  fingerprint = ""
  private_key_path = ""
  region = "us-ashburn-1"
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = "ocid1.compartment.oc1..aaaaaaaadk2lcuzqspj4jj6wts43mjimym5qrhqqt6nzcz6hqrehjjzungxq"
    shape = "VM.Standard2.2"
    display_name = "RD-TEST-02"

    create_vnic_details {
        #Required
        subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaaw737zp2ily2vh2zngv4zwfaej64j337xvzwdj2hnc7wd2dku52sq"
    }
    metadata = {
        ssh_authorized_keys = var.ssh_public_key
    }
    source_details {
        #Required
        source_id = "ocid1.image.oc1.iad.aaaaaaaahjkmmew2pjrcpylaf6zdddtom6xjnazwptervti35keqd4fdylca"
        source_type = "image"
    }
    preserve_boot_volume = false
}