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
  default = "ocid1.compartment.oc1..aaaaaaaa2msdfh2g3n4s6fadsvl2thelw5gtnwhbcsqwcgfg2hcsk7mjc3ya"
}

variable subnet_id {
  type    = string
  default = "ocid1.subnet.oc1.iad.aaaaaaaal4cvjywvkqlmsoz7x2gfs73zcx2xdfddrbboyp5gcdpp33vxcxaa"
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
  default = "ocid1.image.oc1.iad.aaaaaaaawufnve5jxze4xf7orejupw5iq3pms6cuadzjc7klojix6vmk42va"
}

variable def_tag_map {
  type = map(string)
  default = null
}

variable free_tag_map {
  type = map(string)
  default = null
}