provider "oci" {
  region           = var.region
}

terraform {
  required_version = ">= 0.12.0"
}


variable "ssh_public_key" {}
variable "tenancy_ocid" {}
variable "stack_displayname" {}
variable "region" {}
variable "compartment_ocid" {}

/* variable "freeform_tags" {
  type = map(string)
  default = null
}

variable "defined_tags" {
  type = map(string)
  default = null
} */

variable "use_existing_vcn" {
  type    = bool
  default = false
}

variable "existing_vcn_compartment_id" {
  type    = string
  default = ""
}
variable "display_name_prefix" {
  type   = string
  default = "CostGovernance"
}

variable "db_name" {
  type = string
  default = "testdb1"
}

variable "vcn_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "existing_vcn_id" {
  type    = string
  default = ""
}
variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "existing_subnet_compartment_id" {
  type    = string
  default = ""
}
variable "existing_subnet_id" {
  type    = string
  default = ""
}
variable "db_compartment_id" {
  type    = string
  default = ""
}
variable "db_admin_password" {
  type    = string
}
variable "db_wallet_password" {
  type    = string
}
variable "db_license_model" {
  type    = string
  default = "LICENSE_INCLUDED"
}

