# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment
}