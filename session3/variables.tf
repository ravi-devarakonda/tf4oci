#variables for authentication
variable region {
  type    = string
  default = "us-phoenix-1"
}

#variables for instance provision

variable compartment {}
variable subnet_id {}
variable image_id {}

variable ins_count {
  type    = string
  default = "1"
}

variable "this_instance_properties" {
  type = map(string)
  default = {
    vmname = "this-instance"
    shape  = "VM.Standard2.2"
  }
}

variable "other_instance_properties" {
  type = map(string)
  default = {
    vmname = "other-instance"
    shape  = "VM.Standard2.1"
  }
}