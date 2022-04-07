# Terraform-Weight :
This terraform template creates: 
* 1 Virtual Network
* 2 Subnets (1 public and 1 private)
* 1 Load Balancer
* Security group
* VMSS (Creates 3 VM's)
* Managed Postgres service
* Sends the terraform state file to a storage account

Commands to run:
```
terraform workspace select staging
terraform plan -out staging.plan -var-file staging.tfvars
terraform apply
terraform workspace select prod
terraform plan -out prod.plan -var-file prod.tfvars
terraform apply
```
Commands to run in order to get the passwords after apply:
```
terraform output ansible_pass
terraform output web_pass
terraform output postgres_pass
```

##Modules:
* __load balancer:</br>__
Creates a load balancer, public ip, backend pool, rule and a health probe):
```
Health probe checks port 8080
rule accepts traffic from port 8080 to 8080
Uncomment nic backend pool assoc if using the a single vm module
```
* __network:__
</br>Creates a Resource group, security group, Virtual network and 2 subnets
```
Security group has 4 rules;
- allows http(8080) to the world
- allows ssh(22) from the user to the public subnet(web)(change the ip to your own)
- allows ssh(22) from the web application server to the db server
- Denys every other connection to the DB subnet(private)
2 subnets: one private and one public
```
* __managed postgres:__
```
Creates a dns server, postgresql flexible server
```
* __postgres virtual machine:__
```
Creates a NIC and a virtual machine without a public IP, uses datafile to install postgres using docker
[remember to change the password in the file to your own]
```
* __web app virtual machine:__
```
Creates a nic, public ip and a virtual machine:
- Count option is commented out to implement it you need to:
- uncomment, and change the option at the lb module to work accordingly with a couple of instances and nic's
```

* __virtual machine scale set:__
```
Creates a vmss and an autoscaling rule:
Default settings of the autoscaling rule is as follows:
- Minimum machines: 3
- Maximum machines: 10
- CPU percentage to increase amount of machines: 75
- CPU percentage to decrease amount of machines: 25
Uses a datafile to configure the web application, but not completely, some actions are needed to run the application.
```
**Note:**
```
Running the application is not automatic, you still need to:
change the IP sent to okta to the load balancer ip address in the env file.
and run the commands at the end of the datafile that are commented out.
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.97.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Managed_postgres"></a> [Managed\_postgres](#module\_Managed\_postgres) | ./Modules/postgres_managed | n/a |
| <a name="module_ansible_master_vm"></a> [ansible\_master\_vm](#module\_ansible\_master\_vm) | ./Modules/web_vm | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./Modules/load_balancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./Modules/network | n/a |
| <a name="module_vmss"></a> [vmss](#module\_vmss) | ./Modules/vmss | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.ansible_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.postgres_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_tag"></a> [tag](#input\_tag) | Prefix used for all the resources | `string` | `"bootcamp"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ansible_ip"></a> [ansible\_ip](#output\_ansible\_ip) | n/a |
| <a name="output_ansible_pass"></a> [ansible\_pass](#output\_ansible\_pass) | n/a |
| <a name="output_lb_ip"></a> [lb\_ip](#output\_lb\_ip) | n/a |
| <a name="output_postgres_pass"></a> [postgres\_pass](#output\_postgres\_pass) | n/a |
| <a name="output_web_pass"></a> [web\_pass](#output\_web\_pass) | n/a |
<!-- END_TF_DOCS -->