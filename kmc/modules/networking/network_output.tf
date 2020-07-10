output "vcn_details" {
  value = oci_core_vcn.kmc_vcn
}

output "route_table_details" {
  value = oci_core_route_table.KMC_RT_Public
}

output "sec_list_details" {
  value = oci_core_security_list.kmc_sl_public
}