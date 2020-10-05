#variables for authentication
variable region {
  type    = string
  default = "us-phoenix-1"
}

#variables for instance provision

variable compartment {}
variable subnet_id {}
variable image_id {}

variable displayname {
  type    = string
  default = "RD-APACHE2-APP"
}

variable ins_count {
  type    = string
  default = "1"
}

variable shape {
  type    = string
  default = "VM.Standard2.2"
}
