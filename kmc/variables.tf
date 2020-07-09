# Auth
variable tenancy_ocid {
    type = string
    default = "ocid1.tenancy.oc1..aaaaaaaan3bshj6g4mapxorh5nxrsnu7pl5q72vwc7jqcpcz4nojhsmtnafq"
}

/* variable config_file_profile {
    type = string
    default = "/home/rdevarakonda/.oci/config(DEFAULT)"
} */

# Identity
variable compartment_description {
    type = string
    default = "test compartment for network deployment"
}
variable compartment_name {
    type = string
    default = "Terraform_LAB"
}

# Network
## VCN
variable vcn_cidr_block {
    type = string
    default = "172.16.0.0/16"
}
variable vcn_display_name {
    type = string
    default = "KMC-TF-VCN"
}

variable vcn_dns_label {
    type = string
    default = "KMCTFVCN"
}

## Subnet
variable subnet_details {
    type = map(string)
    default = {
        kmc_public_sn1 = "172.16.0.0/24"
        kmc_public_sn2 = "172.16.1.0/24"
        kmc_piblic_sn3 = "172.16.2.0/24"
    }
}