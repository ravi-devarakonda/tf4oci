# Terraform example scripts
Terraform example scripts to deploy resources to Oracle Cloud Infrastructure.

## Prerequisites
1. An OCI Tenancy and an IAM/IDCS user created with the right level of access. If you do not already have a tenancy, you can request a free-tier tenancy from [here](https://www.oracle.com/cloud/free/)
2. User should be enabled with programmatic access to OCI. For instructions on how to setup, [See required Keys & OCIDS](https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs)
3. A Work-Station or a Developer machine (preferably a Linux machine, But Windows will work too)
4. Terraform installed and added to path. If not installed, Download from [here](https://www.terraform.io/downloads.html). For more detailed information on Terraform for OCI, check the official [getting started](https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgetstarted2.htm) page. 
5. OCI Provider. Automatically downloaded during `terraform init`.


## How to use these examples
- clone the repo to your work station. Preferably an Oracle Linux server on OCI (session 3 uses InstancePrincipal which needs a machine on OCI)
- `cd` to each example* directory to review Terraform config scripts
- In each example* directory, make sure to either:
    - add a `terraform.tfvars` file in the directory. See [OCI TFVARS](https://registry.terraform.io/modules/oracle-terraform-modules/compute-instance/oci/2.0.1/examples/instance_default) or 
    - set/export ***system environment variables for authentication***. See `TF_VAR_name` section in [TF environment variables](https://www.terraform.io/docs/commands/environment-variables.html)
- run `terraform init`, `terraform plan` & `terraform apply` to deploy the resource(s)
- finally, run `terraform destroy` to terminate the provisioned resources
<br>
<br>

>**Disclaimer**: This is a personal repository. All code, views or opinions represented here are personal and belong solely to me and do not represent those of people, institutions or organizations that I may or may not be associated with in professional or personal capacity, unless explicitly stated.<br>
<br>*Also **please note**, resources deployed using these example scripts do incur charges. Make sure to terminate the deployed resources/services after your tests, to save/minimize your bills*

