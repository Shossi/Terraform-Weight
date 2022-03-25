module "network"{
  source         = "./Modules/network"
  private_subnet_name = "${var.tag}-Private-Subnet"
  public_subnet_name  = "${var.tag}-Public-Subnet"
  rg_name             = "${var.tag}-ResourceGroup"
  sg_name             = "${var.tag}-SecurityGroup"
  vnet_name           = "${var.tag}-VirtualNetwork"
}
module "vmss" {
  source          = "./Modules/vmss"
  RG              = module.network.Resource_Group
  instance_count  = "3"
  lb_backend      = module.load_balancer.lb_backend
  password        = var.web_password
  subnet          = module.network.Public_Subnet
  tag             = var.tag
  user_data_file  = "./Datafile/web-pm2.sh"
}

module "Postgres_VMachine"{
  source         = "./Modules/postgres_vm"
  vm_name        = "${var.tag}-Postgres-VM"
  nic_name       = "${var.tag}-private-nic"
  RG             = module.network.Resource_Group
  subnet         = module.network.Private_Subnet
  user_data_file = "./Datafile/Postgres.sh"
  password       = var.postgres_password
}
module "load_balancer" {
  source         = "./Modules/load_balancer"
  LB_name        = "${var.tag}-LB"
  RG             = module.network.Resource_Group
#  vm_nic         = module.vmss.nic
  Vnetwork       = module.network.Vnet
}
