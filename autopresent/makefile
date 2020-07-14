SHELL=/bin/bash
.PHONY: all tf_apply tf_plan tf_init clean

all: tf_apply tf_plan tf_init

tf_apply: tf_plan
	@echo "applying.."
	terraform apply -auto-approve
tf_plan: tf_init
	@echo "generating plan.."
	terraform plan
	@echo "##"
	@read
tf_init:
	terraform init
	@echo "##"
	@read
clean:
	@echo "cleaning up provisioned resources.."
	terraform destroy -auto-approve
	rm -rfv .terraform *.tfstate*
