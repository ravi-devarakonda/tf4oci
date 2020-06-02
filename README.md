# Terraform example scripts
Terraform scripts coded/used during the course of training

## pre-reqs
1. terraform installed and added to path. If not installed, Download from [here](https://www.terraform.io/downloads.html) 
2. OCI Provider. Automatically downloaded during `terraform init`.
## How to use
- clone the repo to you local machine
- `cd` to session* directory to run scripts from a particular session
- make sure to either:
    - add a `terraform.tfvars` file in the directory (see [OCI TFVARS](https://registry.terraform.io/modules/oracle-terraform-modules/compute-instance/oci/2.0.1/examples/instance_default) ) or 
    - set/export ***system environment variables for authentication*** (see `TF_VAR_name` section in [TF environment variables](https://www.terraform.io/docs/commands/environment-variables.html))
- run `terraform init`, `terraform plan` & `terraform apply`
- finally, run `terraform destroy` to terminate the provisioned resources

