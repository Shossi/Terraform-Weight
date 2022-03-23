resource "azurerm_network_interface" "NIC" {
  name                = var.nic_name
  location            = var.RG.location
  resource_group_name = var.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "Web_VM" {
  name                = var.vm_name
  resource_group_name = var.RG.name
  location            = var.RG.location
  size                = "Standard_B2s"
  user_data = filebase64(var.user_data_file)
  disable_password_authentication = "false"
  admin_password = var.password
  admin_username      = "ubuntu"

  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}