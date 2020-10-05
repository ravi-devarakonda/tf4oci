#variables for authentication
variable region {
  type    = string
  default = "us-phoenix-1"
}

 variable oci_config_file_profile {
   default = "DEFAULT"
 }

#variables for instance provision

variable compartment {}
variable subnet_id {}
variable image_id {}

variable displayname {
  type    = string
  default = "RD-Default-VM"
}

variable ins_count {
  type    = string
  default = "1"
}

variable shape {
  type    = string
  default = "VM.Standard2.2"
}



variable def_tag_map {
  type = map(string)
  default = null
}

variable free_tag_map {
  type = map(string)
  default = null
}