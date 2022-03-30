output "web_pass" {
  value = module.vmss.password
  sensitive = true
}
output "postgres_pass" {
  value = module.Managed_postgres.password
  sensitive = true
}
output "ansible_pass" {
  value = module.ansible_master_vm.password
  sensitive = true
}
output "lb_ip" {
  value = module.load_balancer.lb_ip
}
output "ansible_ip" {
  value = module.ansible_master_vm.ansible_ip
}