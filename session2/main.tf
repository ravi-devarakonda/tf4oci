#instance provision
resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.compartment
    shape = var.shape
    display_name = var.displayname

    create_vnic_details {
        #Required
        subnet_id = var.subnet_id
    }
    metadata = {
        ssh_authorized_keys = var.ssh_public_key
    }
    source_details {
        #Required
        source_id = var.image_id
        source_type = "image"
    }
    preserve_boot_volume = false
}