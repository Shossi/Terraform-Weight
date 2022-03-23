output "Resource_Group" {
  value = azurerm_resource_group.Boot
}
output "Vnet" {
  value = azurerm_virtual_network.Vnet
}
output "Public_Subnet" {
  value = azurerm_subnet.public_subnet
}
output "Private_Subnet" {
  value = azurerm_subnet.private_subnet
}