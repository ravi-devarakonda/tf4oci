output "Compartment_details" {
   value = {
       compartment_name = module.compartment.compartment_details.name
       compartment_ocid = module.compartment.compartment_details.id
       description = module.compartment.compartment_details.description
       parent_compartment = module.compartment.compartment_details.compartment_id
       time_created = module.compartment.compartment_details.time_created
   }
}

output "VCN_Details" {
    value = {
        VCN_Name = module.create_network.vcn_details.display_name
        VCN_ID = module.create_network.vcn_details.id 
        VCN_dns_label = module.create_network.vcn_details.dns_label
        VCN_domain_name = module.create_network.vcn_details.vcn_domain_name
    }
}