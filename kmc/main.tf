#Identity
/* module compartment {
    source = "./modules/identity/"
    compartment_id          = var.tenancy_ocid
    compartment_description = var.compartment_description
    compartment_name        = var.compartment_name
} */

module create_network {
  #
  source             = "./modules/networking"
  vcn_cidr_block     = var.vcn_cidr_block
  vcn_compartment_id = var.compartment_id
  vcn_display_name   = var.vcn_display_name
  vcn_dns_label      = var.vcn_dns_label
  subnet_details     = var.subnet_details
  sl_details         = var.sl_details
  rt_details         = var.rt_details
  #
}