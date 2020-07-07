# IGW
resource "oci_core_internet_gateway" "kmc_internet_gateway" {
    #Required
    compartment_id = var.vcn_compartment_id
    vcn_id = oci_core_vcn.kmc_vcn.id

    #Optional
    display_name = "KMC-IGW"
}

# NAT GW
resource "oci_core_nat_gateway" "kmc_nat_gateway" {
    #Required
    compartment_id = var.vcn_compartment_id
    vcn_id = oci_core_vcn.kmc_vcn.id

    #optional
    display_name = "KMC-NGW"
}

# DRG
resource "oci_core_drg" "kmc_drg" {
    #Required
    compartment_id = var.vcn_compartment_id

    #Optional
    display_name = "KMC-DRG"
}

resource "oci_core_drg_attachment" "kmc_drg_attachment" {
    #Required
    drg_id = oci_core_drg.kmc_drg.id
    vcn_id = oci_core_vcn.kmc_vcn.id

    #Optional
    display_name = "kmc-drg-attachment-${oci_core_vcn.kmc_vcn.display_name}"
}