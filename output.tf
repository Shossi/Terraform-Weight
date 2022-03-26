output "Web_Pass" {
  value = var.web_password
}
output "postgres_pass" {
  value = var.postgres_password
}
output "lb_ip" {
  value = module.load_balancer.lb_ip
}