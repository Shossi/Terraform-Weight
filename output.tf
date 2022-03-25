output "Web_Pass" {
  value = var.web_password
  sensitive = true
}

output "postgres_pass" {
  value = var.postgres_password
  sensitive = true
}
output "lb_ip" {
  value = module.load_balancer.lb_ip
}