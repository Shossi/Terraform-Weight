module "network"{
  source              = "../Modules/network"
  rg_name             = "${var.tag}-Resource-Group"
  sg_name             = "${var.tag}-Security-Group"
  vnet_name           = "${var.tag}-virtual-network"
  public_subnet_name  = "${var.tag}-public-subnet"
  private_subnet_name = "${var.tag}-private-subnet"
}
module "Web_VMachine" {
  # instance_count = 2
  source         = "../Modules/web_vm"
  vm_name        = "${var.tag}-Web-App"
  nic_name       = "${var.tag}-public-nic"
  RG             = module.network.Resource_Group
  subnet         = module.network.Public_Subnet
  user_data_file = "../DataFile/web-pm2.sh"
  password       = var.web_password
}
module "Postgres_VMachine"{
  source         = "../Modules/postgres_vm"
  vm_name        = "Postgres-VM"
  nic_name       = "private-nic"
  RG             = module.network.Resource_Group
  subnet         = module.network.Private_Subnet
  user_data_file = "../Datafile/Postgres.sh"
  password       = var.postgres_password
}
module "load_balancer" {
  source         = "../Modules/load_balancer"
  LB_name        = "BootCamp-LB"
  RG             = module.network.Resource_Group
  vm_nic         = module.Web_VMachine.nic
  Vnetwork       = module.network.Vnet
}
