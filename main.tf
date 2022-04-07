locals {tag = "${terraform.workspace}-${var.tag}"}

module "ansible_master_vm" {
  source         = "./Modules/web_vm"
  RG             = module.network.Resource_Group
  nic_name       = "${local.tag}-ansible-nic"
  password       = random_password.ansible_password.result
  subnet         = module.network.Public_Subnet
  vm_name        = "${local.tag}-ansible-master"
  user_data_file = "./DataFile/ansible.sh"
}
module "network"{
  source              = "./Modules/network"
  private_subnet_name = "${local.tag}-Private-Subnet"
  public_subnet_name  = "${local.tag}-Public-Subnet"
  rg_name             = "${local.tag}-ResourceGroup"
  sg_name             = "${local.tag}-SecurityGroup"
  vnet_name           = "${local.tag}-VirtualNetwork"
  location            = var.location
}
module "vmss" {
  source          = "./Modules/vmss"
  RG              = module.network.Resource_Group
  instance_count  = var.instance_count
  lb_backend      = module.load_balancer.lb_backend
#  password        = random_password.web_password.result
  subnet          = module.network.Public_Subnet
  tag             = local.tag
#  user_data_file  = "./Datafile/web-pm2.sh"
}

module "Managed_postgres" {
  source         = "./Modules/postgres_managed"
  postgres_pass  = random_password.postgres_password.result
  private_subnet = module.network.Private_Subnet
  rg             = module.network.Resource_Group
  tag            = local.tag
  vnetwork       = module.network.Vnet
}
module "load_balancer" {
  source         = "./Modules/load_balancer"
  LB_name        = "${local.tag}-LB"
  RG             = module.network.Resource_Group
  Vnetwork       = module.network.Vnet
}
resource "local_file" "test" {
  filename = "./${terraform.workspace}-vars.txt"
  depends_on = [
  module.vmss,
  module.Managed_postgres,
  module.load_balancer,
  module.ansible_master_vm
  ]
  content = <<-EOT
  ${terraform.workspace}_ansible_ip=${module.ansible_master_vm.ansible_ip}
  ${terraform.workspace}_postgres_pass=${module.Managed_postgres.password}
  ${terraform.workspace}_web_pass=${module.vmss.password}
  ${terraform.workspace}_ansible_pass=${module.ansible_master_vm.password}
  ${terraform.workspace}_lb_ip=${module.load_balancer.lb_ip}
EOT
}