module "network"{
  source = "./Modules/network"
}
module "Web_VMachine" {
  source         = "./Modules/web_vm"
  vm_name        = "Web-App"
  nic_name       = "public-nic"
  RG             = module.network.Resource_Group
  subnet         = module.network.Public_Subnet
  user_data_file = "./DataFile/WebApp.sh"
}
module "Postgres_VMachine"{
  source   = "./Modules/postgres_vm"
  vm_name  = "Postgres-VM"
  nic_name = "private-nic"
  RG       = module.network.Resource_Group
  subnet   = module.network.Private_Subnet
  user_data_file = "./Datafile/Postgres.sh"
}