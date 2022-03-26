# Terraform-Weight
This terraform template creates: 
* 1 Virtual Network
* 2 Subnets (1 public and 1 private)
* 1 Load Balancer
* Security group
* VMSS (Creates 3 VM's)
* Managed Postgres service
* Sends the terraform state file to a storage account



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.97.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Managed_postgres"></a> [Managed\_postgres](#module\_Managed\_postgres) | ./Modules/postgres_managed | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./Modules/load_balancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./Modules/network | n/a |
| <a name="module_vmss"></a> [vmss](#module\_vmss) | ./Modules/vmss | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default      | Required |
|------|-------------|------|--------------|:--------:|
| <a name="input_postgres_password"></a> [postgres\_password](#input\_postgres\_password) | Postgres password | `string` | `"***"`      | no |
| <a name="input_tag"></a> [tag](#input\_tag) | Prefix used for all the resources | `string` | `"bootcamp"` | no |
| <a name="input_web_password"></a> [web\_password](#input\_web\_password) | Webapp server password | `string` | `"***"`      | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Web_Pass"></a> [Web\_Pass](#output\_Web\_Pass) | n/a |
| <a name="output_lb_ip"></a> [lb\_ip](#output\_lb\_ip) | n/a |
| <a name="output_postgres_pass"></a> [postgres\_pass](#output\_postgres\_pass) | n/a |
<!-- END_TF_DOCS -->