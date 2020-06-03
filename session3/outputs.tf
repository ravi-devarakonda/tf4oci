output "this_instance_details" {
  value = {
    instance_private_ip = module.this_instance.instance_details.*.private_ip
    instance_public_ip  = module.this_instance.instance_details.*.public_ip,
    ocid                = module.this_instance.instance_details.*.id,
    vmname              = module.this_instance.instance_details.*.display_name,
  }
}

output "other_instance_details" {
  value = {
    instance_private_ip = module.other_instance.instance_details.*.private_ip,
    instance_public_ip  = module.other_instance.instance_details.*.public_ip,
    ocid                = module.other_instance.instance_details.*.id,
    vmname              = module.other_instance.instance_details.*.display_name,
  }
}