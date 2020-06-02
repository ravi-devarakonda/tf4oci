variable tenancy_ocid {
    type = string
    default = "ocid1.tenancy.oc1..aaaaaaaajehugl3ryss2gaxf3os7g5w4xdztfhy4coqnoizm2wpmrclnv5da"
}

variable ssh_public_key {
    type = string
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC96kMjy8kLiU3PvUqn/PlFpVGq9VyeiFNphp3u3wf+JJUlxlh4USLC8KM2X2ZF5630s3hXoFMC2fE+7GtAAxdCAM0WkekJO0NO59fMMKy2/ZcKMxUANhw3nTo/1HUF5VOrWMOSNaLBP7O3WOq7tfs6vNbyM9wcXQmrOfKS0iKkKe+O5Q1K0RGKpuW48xUmLTCXeaX7t6ovZpXuTKj8QtSxRTuMUolQyJqr05fdux19lt3m9cnzv2TS/cYVCKOjp715A3mONOJi7izkiTQyggEIZpeQ9ohu6yXOzSUUpHifCyPNvjjt92dRR4es2dp9Xjnn09bYSDltMgA8D/vzQckn rdevarakonda@DEVARAKONDA-PC"
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = "ocid1.user.oc1..aaaaaaaal6brlwaypcrel6nxx3zq4rhua2o4ykh54bwddl56oasaimdtqqpa"
  fingerprint = "eb:ae:8a:a0:3f:8f:5a:83:92:1b:1a:b6:fc:22:42:b0"
  private_key_path = "C:/Users/rsdevara/tf-training/red_api_key.pem"
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