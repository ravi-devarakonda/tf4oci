#variables for authentication
/* variable tenancy_ocid {}
variable user_ocid {}
variable fingerprint {}
variable private_key_path {} */
variable ssh_public_key {
  type =string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC96kMjy8kLiU3PvUqn/PlFpVGq9VyeiFNphp3u3wf+JJUlxlh4USLC8KM2X2ZF5630s3hXoFMC2fE+7GtAAxdCAM0WkekJO0NO59fMMKy2/ZcKMxUANhw3nTo/1HUF5VOrWMOSNaLBP7O3WOq7tfs6vNbyM9wcXQmrOfKS0iKkKe+O5Q1K0RGKpuW48xUmLTCXeaX7t6ovZpXuTKj8QtSxRTuMUolQyJqr05fdux19lt3m9cnzv2TS/cYVCKOjp715A3mONOJi7izkiTQyggEIZpeQ9ohu6yXOzSUUpHifCyPNvjjt92dRR4es2dp9Xjnn09bYSDltMgA8D/vzQckn"
}
variable region {
  type    = string
  default = "us-ashburn-1"
}

 variable ociprofile {
   default = "NATIONAL02"
 }

#variables for instance provision

variable compartment {
  type    = string
  #default = "ocid1.compartment.oc1..aaaaaaaadk2lcuzqspj4jj6wts43mjimym5qrhqqt6nzcz6hqrehjjzungxq"
  default = "ocid1.compartment.oc1..aaaaaaaac4zmgwwe2pg2iraydy7lutqyugj22udiku5feq6inwfcrg6lyaja"
}

variable subnet_id {
  type    = string
  #default = "ocid1.subnet.oc1.iad.aaaaaaaaw737zp2ily2vh2zngv4zwfaej64j337xvzwdj2hnc7wd2dku52sq"
  default = "ocid1.subnet.oc1.iad.aaaaaaaakqi3d4yf2bb5kjuvzjv5rqnshinpcpbtrosxwiycfr2usgrbdd4a"
}

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

variable image_id {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaahjkmmew2pjrcpylaf6zdddtom6xjnazwptervti35keqd4fdylca"
}

variable def_tag_map {
  type = map(string)
  default = null
}

variable free_tag_map {
  type = map(string)
  default = null
}