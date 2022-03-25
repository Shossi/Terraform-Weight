output "lb_backend" {
  value = azurerm_lb_backend_address_pool.backend_pool
}
output "lb_ip" {
  value = azurerm_public_ip.lb_ip.ip_address
}