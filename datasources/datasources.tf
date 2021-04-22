data "oci_identity_compartments" "top_level" {
  compartment_id = var.TENANCY_OCID
  state          = "ACTIVE"
}
data "oci_identity_compartments" "sec_level" {
  for_each       = toset(local.top_level_compartments)
  compartment_id = each.key
  state          = "ACTIVE"
}

data "oci_objectstorage_bucket_summaries" "test_buckets" {
    #Required
    for_each       = toset(local.all_compartments)
    compartment_id = each.key
    namespace = "orasenatdpltintegration03"
}

locals {
  top_level_compartments = [for c in data.oci_identity_compartments.top_level.compartments : c.id]
  sec_level_compartments = flatten([for c in local.top_level_compartments : [for c2 in data.oci_identity_compartments.sec_level[c].compartments : c2.id]])
  all_compartments       = concat([var.TENANCY_OCID], local.top_level_compartments, local.sec_level_compartments)
  all_buckets            = flatten([for c in local.all_compartments : [for bkt in data.oci_objectstorage_bucket_summaries.test_buckets[c].bucket_summaries : bkt.name]])
  
}


/* output "comp_data" {
    value = data.oci_identity_compartments.top_level
} */


output "buckets" {
    value = local.all_buckets
}

/* output "buckets" {
    value = data.oci_objectstorage_bucket_summaries.test_buckets
} */
