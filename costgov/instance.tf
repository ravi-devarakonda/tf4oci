data "oci_resourcemanager_stacks" "mp_stack" {
    #Optional
    compartment_id = var.compartment_ocid
    display_name = var.stack_displayname
    state = "ACTIVE"
}

resource "oci_core_instance" "app-instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "Official Marketplace"
  shape               = local.instance_shape

  create_vnic_details {
    subnet_id        = var.use_existing_vcn ? join("", data.oci_core_subnet.subnet.*.id) : join("", oci_core_subnet.subnet.*.id)
    display_name     = "primaryvnic"
    assign_public_ip = true
    # hostname_label   = "test"
  }

  source_details {
    source_type = "image"
    source_id   = local.images[var.region]
  }

  extended_metadata = {
    wallet_file         = data.oci_database_autonomous_database_wallet.autonomous_data_warehouse_wallet.content
    atp_pw              = var.db_admin_password
    db_name             = oci_database_autonomous_database.autonomous_data_warehouse.db_name
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(var.user-data)
  }

  timeouts {
    create = "60m"
  }
  #
  freeform_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].freeform_tags
  defined_tags = data.oci_resourcemanager_stacks.mp_stack.stacks[0].defined_tags
}


variable "user-data" {
  default = <<EOF
#!/bin/bash -x
echo '################### executing SQL scripts #####################'
touch ~opc/userdata.start
sudo su -
export CLIENT_HOME=/usr/lib/oracle/19.6/client64
export LD_LIBRARY_PATH=$CLIENT_HOME/lib
export PATH=$PATH:$CLIENT_HOME/bin
mkdir wallets
export TNS_ADMIN=/home/opc/wallets

ADW_PW=$(curl -L http://169.254.169.254/opc/v1/instance/metadata | jq --raw-output '.atp_pw')
DB_NAME=$(curl -L http://169.254.169.254/opc/v1/instance/metadata | jq --raw-output '.db_name')
INSTANCE_ID=$(curl -L http://169.254.169.254/opc/v1/instance/| jq --raw-output '.id')
curl -L http://169.254.169.254/opc/v1/instance/metadata | jq --raw-output '.wallet_file' > wallet_file

base64 --decode wallet_file > wallet.zip

unzip wallet.zip -d /home/opc/wallets/

printf "unzip successful\n" >> /home/opc/userdata.start

cp /home/opc/sqlnet.ora /home/opc/wallets/sqlnet.ora
if [ $? -ne 0 ]; then
   printf "error copying sqlnet.ora\n" >> /home/opc/userdata.start
else
   printf "sqlnet.ora copy successful\n" >> /home/opc/userdata.start
fi

echo $ADW_PW | sqlplus admin@`echo $DB_NAME`_low @/home/opc/create_apex_user.sql costgov `echo $ADW_PW` >> /home/opc/output.txt

/home/opc/bin/oci compute instance update --instance-id `echo $INSTANCE_ID` --extended-metadata file://extended.json --auth instance_principal --force

touch ~opc/userdata.`date +%s`.finish

rm -rf wallet*
rm -rf ~opc/wallet*
echo '################### Executed SQL scripts #######################'
EOF
}

// https://docs.cloud.oracle.com/iaas/images/image/4e74174f-0b44-4447-bb09-dc05b23cf3ee/
// Oracle-Linux-7.7-2019.08.28-0
locals  {
  images = {
    ap-mumbai-1    =	"ocid1.image.oc1.ap-mumbai-1.aaaaaaaanqnm77gq2dpmc2aih2ddlwlahuv2qwmokufb7zbi52v67pzkzycq"
    ap-seoul-1     =	"ocid1.image.oc1.ap-seoul-1.aaaaaaaav3lc5w7cvz5yr6hpjdubxupjeduzd5xvaroyhjg6vwqzsdvgus6q"
    ap-sydney-1    =	"ocid1.image.oc1.ap-sydney-1.aaaaaaaagtfumjxhosxrkgfci3dgwvsmp35ip5nbhy2rypxfh3rwtqsozkcq"
    ap-tokyo-1     =	"ocid1.image.oc1.ap-tokyo-1.aaaaaaaajousbvplzyrh727e3d4sb6bam5d2fomwhbtzatoun5sqcuvvfjnq"
    ca-toronto-1   =	"ocid1.image.oc1.ca-toronto-1.aaaaaaaavr35ze44lkflxffkhmt4xyamkfjpbjhsm5awxjwlnp3gpx7h7fgq"
    eu-frankfurt-1 =	"ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa7gj6uot6tz6t34qjzvkldxtwse7gr5m7xvnh6xfm53ddxp3w37ja"
    eu-zurich-1    =	"ocid1.image.oc1.eu-zurich-1.aaaaaaaasl3mlhvgzhfglqqkwdbppmmgomkz6iyi42wjkceldqcpecg7jzgq"
    sa-saopaulo-1  =	"ocid1.image.oc1.sa-saopaulo-1.aaaaaaaawamujpmwxbjgrfeb66zpew5sgz4bimzb4wgcwhqdjyct53bucvoq"
    uk-london-1    =	"ocid1.image.oc1.uk-london-1.aaaaaaaa6trfxqtp5ib7yfgj725js3o6agntmv6vckarebsmacrhdxqojeya"
    us-ashburn-1   =	"ocid1.image.oc1.iad.aaaaaaaavvctw4zh2trwp6xtta2ttxh45bivuffltccqydkmvtyw6ppy6pla"
    us-langley-1   =	"ocid1.image.oc1.iad.aaaaaaaa2qha6744iebmhbasswf52id73aeoaeqf2icjesc5d5vngw4hnjaa"
    us-luke-1      =	"ocid1.image.oc2.us-luke-1.aaaaaaaa73qnm5jktrwmkutf6iaigib4msieymk2s5r5iweq5yvqublgcx5q"
    us-phoenix-1   =	"ocid1.image.oc1.phx.aaaaaaaadtmpmfm77czi5ghi5zh7uvkguu6dsecsg7kuo3eigc5663und4za"
  }

  
  instance_shape = "VM.Standard2.1"


}

output "public_ip" {
  value = oci_core_instance.app-instance.public_ip
}

output "Instructions" {
  value = "Please click the Apex URL to further complete the process. Use admin username and password that was provided during provisioning."
}


