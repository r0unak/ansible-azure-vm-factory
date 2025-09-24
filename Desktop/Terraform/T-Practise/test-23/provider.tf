terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.45.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }

  }

  required_version = ">= 1.9.0"

    backend "azurerm" {
    resource_group_name   = "stg"
    storage_account_name  = "stateaks"
    container_name        = "state"
    key                   = "test.terraform.tfstate"
  }  
}

# configures the provider

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks-rg" {
  name = "myrg"
  location = "east us"
  
}
