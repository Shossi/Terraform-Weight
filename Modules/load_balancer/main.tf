resource "azurerm_public_ip" "lb_ip" {
  name                = "PublicIPForLB"
  location            = var.RG.location
  resource_group_name = var.RG.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.LB_name
  location            = var.RG.location
  resource_group_name = var.RG.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "lb_IPAddress"
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}
#resource "azurerm_network_interface_backend_address_pool_association" "assoc1" {
#  network_interface_id    = var.vm_nic.id
#  ip_configuration_name   = "internal"
#  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
#}
resource "azurerm_lb_rule" "example" {
  resource_group_name            = var.RG.name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "HTTP_lb_rule"
  protocol                       = "TCP"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id = azurerm_lb_probe.probe.id
}
resource "azurerm_lb_probe" "probe" {
  resource_group_name = var.RG.name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "http-port8080-running-probe"
  protocol            = "HTTP"
  port                = 8080
  request_path        = "/"
}