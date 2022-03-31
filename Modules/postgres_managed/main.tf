resource "azurerm_private_dns_zone" "private_dns" {
  name                = "${var.tag}.postgres.database.azure.com"
  resource_group_name = var.rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "${var.tag}VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = var.vnetwork.id
  resource_group_name   = var.rg.name
}
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                   = "${var.tag}-psqlflexibleserver"
  resource_group_name    = var.rg.name
  location               = var.rg.location
  version                = "13"
  delegated_subnet_id    = var.private_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns.id
  administrator_login    = "psqladmin"
  administrator_password = var.postgres_pass
  storage_mb = 32768
  zone = "1"
  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_link]
}
resource "azurerm_postgresql_flexible_server_configuration" "rm_ssl" {
  name                = "require_secure_transport"
  server_id           = azurerm_postgresql_flexible_server.postgres.id
  value               = "off"
}