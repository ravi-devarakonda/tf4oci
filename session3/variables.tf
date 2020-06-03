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
  default = "ocid1.compartment.oc1..aaaaaaaadk2lcuzqspj4jj6wts43mjimym5qrhqqt6nzcz6hqrehjjzungxq"
}

variable subnet_id {
  type    = string
  default = "ocid1.subnet.oc1.iad.aaaaaaaaw737zp2ily2vh2zngv4zwfaej64j337xvzwdj2hnc7wd2dku52sq"
}

variable ins_count {
  type    = string
  default = "1"
}

variable image_id {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaahjkmmew2pjrcpylaf6zdddtom6xjnazwptervti35keqd4fdylca"
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