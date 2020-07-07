variable vcn_cidr_block {}
variable vcn_compartment_id {}
variable vcn_display_name {}
variable vcn_dns_label {}
# VCN
resource "oci_core_vcn" "kmc_vcn" {
    #Required
    cidr_block = var.vcn_cidr_block
    compartment_id = var.vcn_compartment_id

    #Optional
    display_name = var.vcn_display_name
    dns_label = var.vcn_dns_label
}

# Route Tables
resource "oci_core_route_table" "KMC_RT_Public" {
    #Required
    compartment_id = var.vcn_compartment_id
    vcn_id = oci_core_vcn.kmc_vcn.id

    #Optional
    display_name = "KMC_RT_Public"
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.kmc_internet_gateway.id

        #Optional
        cidr_block = "0.0.0.0/0"
    }
}

resource "oci_core_route_table" "KMC_RT_Private" {
    #Required
    compartment_id = var.vcn_compartment_id
    vcn_id = oci_core_vcn.kmc_vcn.id

    #Optional
    display_name = "KMC_RT_Private"
    route_rules {
        #Required
        network_entity_id = oci_core_nat_gateway.kmc_nat_gateway.id

        #Optional
        cidr_block = "0.0.0.0/0"
    }
}
#