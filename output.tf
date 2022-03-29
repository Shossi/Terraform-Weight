output "Web_Pass" {
  value = module.vmss.password
}
output "postgres_pass" {
  value = module.Managed_postgres.password
}
output "lb_ip" {
  value = module.load_balancer.lb_ip
}