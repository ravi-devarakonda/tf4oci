module "this_instance" {
  source           = "./modules/instance"
  compartment      = var.compartment
  shape            = var.this_instance_properties["shape"]
  displayname      = var.this_instance_properties["vmname"]
  ins_count        = var.ins_count
  subnet_id        = var.subnet_id
  ssh_public_key   = var.ssh_public_key
  image_id         = var.image_id
  assign_public_ip = "true"
}

module "other_instance" {
  source           = "./modules/instance"
  compartment      = var.compartment
  shape            = var.other_instance_properties["shape"]
  displayname      = var.other_instance_properties["vmname"]
  ins_count        = var.ins_count
  subnet_id        = var.subnet_id
  ssh_public_key   = var.ssh_public_key
  image_id         = var.image_id
  assign_public_ip = "true"
}