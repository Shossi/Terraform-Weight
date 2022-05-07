resource "azurerm_resource_group" "boot" { # Creating a resource group
  name     = var.rg_name
  location = var.location
}
#resource "azurerm_virtual_network" "k8s_vnet" {
#  name                = "k8s-vnet"
#  location            = azurerm_resource_group.boot.location
#  resource_group_name = azurerm_resource_group.boot.name
#  address_space       = ["10.1.0.0/16"]
#  tags = {
#    environment = "Development"
#  }
#}
#resource "azurerm_subnet" "aks-subnet" {
#  name                 = "aks-subnet"
#  virtual_network_name = azurerm_virtual_network.k8s_vnet.name
#  resource_group_name  = azurerm_resource_group.boot.name
#  address_prefixes     = ["10.1.0.0/24"]
#}

resource "azurerm_container_registry" "ACR" {
  name                = "BootACR"
  resource_group_name = azurerm_resource_group.boot.name
  location            = azurerm_resource_group.boot.location
  sku                 = "Basic"
  admin_enabled       = true
}
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "boot-k8s"
  location            = azurerm_resource_group.boot.location
  resource_group_name = azurerm_resource_group.boot.name
  dns_prefix          = "boot-k8s"

  default_node_pool {
    name       = "bootpool"
    node_count = 1
    vm_size    = "Standard_B2s"
#    vnet_subnet_id = azurerm_subnet.aks-subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = "Standard_B2s"
  node_count            = 2

  tags = {
    Environment = "Production"
  }
}

#pod_subnet_id -
#(Optional) The ID of the Subnet where the pods in the default Node Pool should exist.
#Changing this forces a new resource to be created.
#vnet_subnet_id -
#(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist.
#Changing this forces a new resource to be created.
#A Route Table must be configured on this Subnet.
#An ingress_application_gateway block supports the following:

#gateway_id -
#(Optional) The ID of the Application Gateway to integrate with the ingress
#controller of this Kubernetes Cluster. See this page for further details.
##
#
##gateway_name
#- (Optional) The name of the Application Gateway to be used or created
# in the Nodepool Resource Group,
#which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
#See this page for further details.
##
#
##subnet_cidr
#- (Optional) The subnet CIDR to be used to create an Application Gateway,
#which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
#See this page for further details.
##
#
##subnet_id -
#(Optional) The ID of the subnet on which to create an Application Gateway,
#which in turn will be integrated with the ingress controller of this Kubernetes Cluster.
#See this page for further details.