#variables for authentication
variable tenancy_ocid {}
variable user_ocid {}
variable fingerprint {}
variable private_key_path {}
variable ssh_public_key {}
variable region {
  type    = string
  default = "us-ashburn-1"
}

#variables for instance provision

variable compartment {
  type    = string
  default = "ocid1.compartment.oc1..aaaaaaaa2msdfh2g3n4s6fadsvl2thelw5gtnwhbcsqwcgfg2hcsk7mjc3ya"
}

variable subnet_id {
  type    = string
  default = "ocid1.subnet.oc1.iad.aaaaaaaal4cvjywvkqlmsoz7x2gfs73zcx2xdfddrbboyp5gcdpp33vxcxaa"
}

variable ins_count {
  type    = string
  default = "1"
}

variable image_id {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaawufnve5jxze4xf7orejupw5iq3pms6cuadzjc7klojix6vmk42va"
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
    shape  = "VM.Standard2.4"
  }
}