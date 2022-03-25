resource "azurerm_resource_group" "Boot" { # Creating a resource group
  name     = var.rg_name
  location = "West US 3"
}

resource "azurerm_network_security_group" "SG" { # Create a security group
  name                = var.sg_name
  location            = azurerm_resource_group.Boot.location
  resource_group_name = azurerm_resource_group.Boot.name
security_rule {
    name                       = "SSH to Public Subnet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "83.130.29.0/24"
    destination_address_prefix = "10.0.0.0/24"
  }
  security_rule {
    name                       = "Allow 8080 to public subnet"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/24"
  }
  security_rule {
    name                       = "SSH to Private Subnet"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "10.0.199.0/24"
  }
  security_rule {
    name                       = "Allow access to DB from the web vm"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "10.0.199.0/24"
  }
  security_rule {
    name                       = "Deny every other connection to the Private Subnet"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.199.0/24"
  }
}
resource "azurerm_subnet_network_security_group_association" "public_assoc" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.SG.id
}
resource "azurerm_subnet_network_security_group_association" "private_assoc" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.SG.id
}
resource "azurerm_virtual_network" "Vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.Boot.location
  resource_group_name = azurerm_resource_group.Boot.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "Development"
  }
}
resource "azurerm_subnet" "public_subnet" {
  name                 = var.public_subnet_name
  resource_group_name  = azurerm_resource_group.Boot.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
resource "azurerm_subnet" "private_subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = azurerm_resource_group.Boot.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.199.0/24"]
}