variable subnet_details {}
resource "oci_core_subnet" "kmc_subnets" {
  for_each = var.subnet_details
  #Required
  cidr_block     = each.value
  compartment_id = var.vcn_compartment_id
  vcn_id         = oci_core_vcn.kmc_vcn.id

  #Optional
  display_name      = each.key
  #route_table_id    = oci_core_route_table.KMC_RT_Public[var.rt_details[count.index]].id
  #security_list_ids = [oci_core_security_list.kmc_sl_public[var.rt_details[count.index]].id]
}