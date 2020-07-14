locals {
  all_cidr            = "0.0.0.0/0"
  use_existing_vcn = var.use_existing_vcn
  existing_subnet_id = var.existing_subnet_id
}

resource "oci_core_vcn" "vcn" {
  count          = local.use_existing_vcn ? 0 : 1
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "${var.display_name_prefix}-vcn"
  dns_label      = "costvcn"
  #
  freeform_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].freeform_tags
  defined_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].defined_tags
}

data "oci_core_vcn" "vcn" {
  count          = local.use_existing_vcn ? 1 : 0
  vcn_id         = var.existing_vcn_id
}

locals {
  vcn_id         = local.use_existing_vcn ? join("", data.oci_core_vcn.vcn.*.id) : join("", oci_core_vcn.vcn.*.id)
  vcn_compartment_id = local.use_existing_vcn ? join("", data.oci_core_vcn.vcn.*.compartment_id) : join("", oci_core_vcn.vcn.*.compartment_id)
  route_table_id = local.use_existing_vcn ? join("", data.oci_core_vcn.vcn.*.default_route_table_id) : join("", oci_core_vcn.vcn.*.default_route_table_id)
  dhcp_options_id= local.use_existing_vcn ? join("", data.oci_core_vcn.vcn.*.default_dhcp_options_id) : join("", oci_core_vcn.vcn.*.default_dhcp_options_id)
}

resource "oci_core_internet_gateway" "internet_gateway" {
  count          = local.use_existing_vcn ? 0 : 1
  compartment_id = local.vcn_compartment_id
  display_name   = "${var.display_name_prefix}-internet-gateway"
  vcn_id         = local.vcn_id
  #
  freeform_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].freeform_tags
  defined_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].defined_tags
}

resource "oci_core_default_route_table" "default_route_table" {
  count          = local.use_existing_vcn ? 0 : 1
  manage_default_resource_id = local.route_table_id
  display_name               = "${var.display_name_prefix}-internet-route-table"
  # 
  freeform_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].freeform_tags
  defined_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].defined_tags
  #
  route_rules {
    destination       = local.all_cidr
    destination_type  = "CIDR_BLOCK"
    network_entity_id = join("", oci_core_internet_gateway.internet_gateway.*.id)
  }
}

resource "oci_core_route_table_attachment" "application" {
  count          = local.use_existing_vcn ? 0 : 1
  subnet_id      = join("", oci_core_subnet.subnet.*.id)
  route_table_id = local.route_table_id
  
}



resource "oci_core_security_list" "bastion" {
  count          = local.use_existing_vcn ? 0 : 1
  compartment_id = local.vcn_compartment_id
  vcn_id         = local.vcn_id
  display_name   = "${var.display_name_prefix}-bastion"
  #
  freeform_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].freeform_tags
  defined_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].defined_tags
  #
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = local.all_cidr
    stateless = false

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    // Allow inbound ssh traffic...
    protocol  = "6" // tcp
    source    = local.all_cidr
    stateless = false

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    // Allow inbound ssh traffic...
    protocol  = "6" // tcp
    source    = local.all_cidr
    stateless = false

    tcp_options {
      min = 4200
      max = 4200
    }
  }

  ingress_security_rules {
    // allow inbound icmp traffic of a specific type
    protocol  = 1
    source    = local.all_cidr
    stateless = false

    icmp_options {
      type = 3
      code = 4
    }
  }

  egress_security_rules {
    // Allow all outbound traffic
    destination      = local.all_cidr
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }
}

resource "oci_core_subnet" "subnet" {
  count          = local.use_existing_vcn ? 0 : 1
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = var.subnet_cidr
  display_name        = "${var.display_name_prefix}-subnet"
  dns_label           = "testsubnet"
  security_list_ids   = oci_core_security_list.bastion.*.id
  compartment_id      = var.compartment_ocid
  vcn_id              = local.vcn_id
  route_table_id      = local.route_table_id
  dhcp_options_id     = local.dhcp_options_id
  #
  freeform_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].freeform_tags
  defined_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].defined_tags
}

data "oci_core_subnet" "subnet" {
  count     = local.use_existing_vcn ? 1 : 0
  subnet_id = local.existing_subnet_id
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}
