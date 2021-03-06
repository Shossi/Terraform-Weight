output "nic" {
  value = azurerm_network_interface.NIC
}
output "password" {
  value = azurerm_linux_virtual_machine.Web_VM.admin_password
}
output "ansible_ip" {
  value = azurerm_linux_virtual_machine.Web_VM.public_ip_address
}