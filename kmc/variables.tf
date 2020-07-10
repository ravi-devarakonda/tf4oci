# Auth
/* variable tenancy_ocid {
    type = string
    #default = "ocid1.tenancy.oc1..aaaaaaaan3bshj6g4mapxorh5nxrsnu7pl5q72vwc7jqcpcz4nojhsmtnafq"
    default = "ocid1.tenancy.oc1..aaaaaaaaeoc4qnlqxk54qe4vpbmsb3dm7jc7tvpxvwv5lum6j6zszy7hjjwa"
} */

variable config_file_profile {
  type    = string
  default = "NATIONAL02"
}

# Identity
/* variable compartment_description {
    type = string
    default = "test compartment for network deployment"
}
variable compartment_name {
    type = string
    default = "Terraform_LAB"
} */
variable compartment_id {
  type = string
  #default = "ocid1.compartment.oc1..aaaaaaaatxy4ktw5wh7i4cl2xlb26ygaamcvjq6o5brgano5fdwifi7qgbrq"
  default = "ocid1.compartment.oc1..aaaaaaaac4zmgwwe2pg2iraydy7lutqyugj22udiku5feq6inwfcrg6lyaja"
}

# Network
## VCN
variable vcn_cidr_block {
  type    = string
  default = "172.16.0.0/16"
}
variable vcn_display_name {
  type    = string
  default = "PROD-KMC-VCN"
}

variable vcn_dns_label {
  type    = string
  default = "PRODKMCVCN"
}

## Subnet
variable subnet_details {
  type = map(string)
  default = {
    bastion-subnet   = "172.16.0.0/26"
    prod-db-subnet   = "172.16.1.0/26"
    prod-db-backup   = "172.16.2.0/26"
    prod-apps-subnet = "172.16.3.0/26"
    dev-db-subnet    = "172.16.4.0/26"
    dev-apps-subnet  = "172.16.5.0/26"
  }
}

variable sl_details {
  type = map(string)
  default = {
    sl1 = "bastion-sl"
    sl2 = "prod-db-sl"
    sl3 = "prod-db-backup-sl"
    sl4 = "prod-apps-sl"
    sl5 = "dev-db-sl"
    sl6 = "dev-apps-sl"
  }
}

variable rt_details {
  type = map(string)
  default = {
    rt1 = "bastion-rt"
    rt2 = "prod-db-rt"
    rt3 = "prod-db-backup-rt"
    rt4 = "prod-apps-rt"
    rt5 = "dev-db-rt"
    rt6 = "dev-apps-rt"
  }
}