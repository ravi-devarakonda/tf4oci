#instance provision
resource "oci_core_instance" "test_instance" {
  count = var.ins_count
  #Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment
  shape               = var.shape
  display_name        = "${var.displayname}-${count.index}"

  create_vnic_details {
    #Required
    subnet_id      = var.subnet_id
    hostname_label = "${var.displayname}-${count.index}"
  }
  metadata = {
    ssh_authorized_keys = file("/home/opc/.ssh/id_rsa.pub")
  }
  source_details {
    #Required
    source_id   = var.image_id
    source_type = "image"
  }
  preserve_boot_volume = false
  defined_tags = var.def_tag_map
  freeform_tags = var.free_tag_map
}

output "private_ips" {
  value = oci_core_instance.test_instance.*.private_ip
}

output "public_ips" {
  value = oci_core_instance.test_instance.*.public_ip
}