terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
#  backend "azurerm" {
#    resource_group_name  = "tfstate"
#    storage_account_name = "tfstate1599945607"
#    container_name       = "tfstate"
#    key                  = "terraforms.tfstate"
#  }
}



# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
