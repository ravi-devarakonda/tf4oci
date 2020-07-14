resource "oci_database_autonomous_database" "autonomous_data_warehouse" {
  #Required
  admin_password           = var.db_admin_password
  compartment_id           = var.db_compartment_id
  cpu_core_count           = "1"
  data_storage_size_in_tbs = "1"
  db_name                  = var.db_name
  display_name            = "OCI Cost governance"
  license_model           = var.db_license_model
  db_version              = "19c"
  db_workload             = "DW"
  is_auto_scaling_enabled = "false"
  # defined_tags = {
  #   "${merge(local.common_def_tags)}"
  # }
  # freeform_tags = {
  #   "${merge(local.common_freeform_tags)}"
  # }

/*   freeform_tags = var.freeform_tags
  defined_tags = var.defined_tags */
  freeform_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].freeform_tags
  defined_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].defined_tags
}

data "oci_database_autonomous_database_wallet" "autonomous_data_warehouse_wallet" {
  autonomous_database_id = oci_database_autonomous_database.autonomous_data_warehouse.id
  password               = var.db_wallet_password
  base64_encode_content  = "true"
}

output "Apex_URL" {
  value = oci_database_autonomous_database.autonomous_data_warehouse.connection_urls.0.apex_url
}



