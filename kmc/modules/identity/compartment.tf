variable compartment_id {}
variable compartment_description {}
variable compartment_name {}

resource "oci_identity_compartment" "kmc_compartment" {
    #Required
    compartment_id = var.compartment_id
    description = var.compartment_description
    name = var.compartment_name

    #Optional
    enable_delete = true
}