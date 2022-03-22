resource "azurerm_resource_group" "Boot" { # Creating a resource group
  name     = "BootCamp-ResourceGroup"
  location = "West US 3"
}

resource "azurerm_network_security_group" "SG" { # Create a security group
  name                = "BootCamp-security-group"
  location            = azurerm_resource_group.Boot.location
  resource_group_name = azurerm_resource_group.Boot.name
  security_rule {
#    count                      = 2
    name                       = "SSH"
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
    #    count                      = 2
    name                       = "HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/24"
  }
}

resource "azurerm_virtual_network" "Vnet" {
  name                = "Boot-Vnetwork"
  location            = azurerm_resource_group.Boot.location
  resource_group_name = azurerm_resource_group.Boot.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "Development"
  }
}
resource "azurerm_subnet" "public" {
  name                 = "Public-subnet"
  resource_group_name  = azurerm_resource_group.Boot.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}
resource "azurerm_subnet" "private" {
  name                 = "xPrivate-subnet"
  resource_group_name  = azurerm_resource_group.Boot.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.199.0/24"]
}