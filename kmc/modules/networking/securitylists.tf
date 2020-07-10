variable sl_details {}
# Security Lists
resource "oci_core_security_list" "kmc_sl_public" {
  for_each       = var.sl_details
  compartment_id = var.vcn_compartment_id
  vcn_id         = oci_core_vcn.kmc_vcn.id
  display_name   = each.value

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  // allow inbound ssh traffic from a specific port
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "76.250.172.155/32"
    stateless = false

    tcp_options {
      // These values correspond to the destination port range.
      min = 22
      max = 22
    }

  }

  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "208.118.199.15/32"
    stateless = false

    tcp_options {
      // These values correspond to the destination port range.
      min = 22
      max = 22
    }
  }
}