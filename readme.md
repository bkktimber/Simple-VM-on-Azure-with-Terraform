#Make Simple VM with Terraform

In this example, I create simple VM with [Terraform](https://www.terraform.io/).

Terraform is useful in managing cloud infrastructure since you can config almost everything it is needed to provision stable and secure infrastruture. Terraform is compatible with most cloud providers.

In this demo, I create VM on Azure with following configuration:

 1. VM
 	* 1.1 OS: Ubuntu, 16.04 LTS
 	* 1.2 Data Drive: /sda0, 1023 GB

 2. Virtual Network
 	* 2.1 Address Space: 10.0.0.0/16
 	*	Subent: 10.0.0.0/24
 	*	IP Address: 10.0.2.5
 	*	Public IP Address: Dynamic, assigned by AzureRM
 3. NSG
 	* Default: Deny all connection from all port
 	* Rule 0: Allow ssh from anyone to port 22

 Lets start!

 1. Clone this repo

 2. Install [terraform](https://www.terraform.io/downloads.html)

 3. Run `terraform init` in simple-vm directory 

 4. Config subscription detail in subscrition.tfvars

 5. Run

 	 `terraform plan -var-file=subscription.tfvars \
 	 -var-file=resource-group.tfvars -var-file=network-parameter.tfvars \ -var-file=storage-account.tfvars -var-file=vm.tfvars`

	Terraform will summary your deplyment. It will look like this:

![terraform-plan](/pic/terraform-plan.png?raw=true "terraform-plan")
	
6. Everthing looks great?, then run this to deploy your plan:

	`terraform apply -var-file=subscription.tfvars \
	-var-file=resource-group.tfvars -var-file=network-parameter.tfvars \
	-var-file=storage-account.tfvars -var-file=vm.tfvars`

	It will look like this:

![terraform-apply](/pic/terraform-apply.png?raw=true "terraform-apply")

7. Take a look in your portal and see if everthing work correctly.
	
8. You can also make graph with terraform with `terraform graph`. The output is VizGraph, so you will need [dot](http://www.graphviz.org/) This is very useful for debug.

	I've made example here:

![terraform-graph](/pic/simple-vm.png?raw=true "simple-vm-graph")

9. The last step is to delete everthing. Run this:

	`terraform destroy -var-file=subscription.tfvars \
	-var-file=resource-group.tfvars -var-file=network-parameter.tfvars \
	-var-file=storage-account.tfvars -var-file=vm.tfvars`

	Don't forget to double check in your azure portal!
