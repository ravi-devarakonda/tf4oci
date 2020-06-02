#instance provision
resource "oci_core_instance" "test_instance" {
    count = var.ins_count
    #Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = var.compartment
    shape = var.shape
    display_name = "${var.displayname}-${count.index+1}"

    create_vnic_details {
        #Required
        subnet_id = var.subnet_id
        hostname_label = "${var.displayname}-${count.index+1}"
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

output "instance_details" {
    value = oci_core_instance.test_instance.*
}