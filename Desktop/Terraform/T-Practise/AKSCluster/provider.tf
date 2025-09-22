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
    key                   = "dev.terraform.tfstate"
  }  
}

# configures the provider

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "random_pet" "aksrandom" {
}