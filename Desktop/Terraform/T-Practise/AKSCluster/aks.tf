
data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.aks-rg.location
  include_preview = false
}

resource "azurerm_log_analytics_workspace" "log" {
  name                = "logs-${random_pet.aksrandom.id}"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

data "azuread_client_config" "current" {}

resource "azuread_group" "ad" {
  display_name     = "ad"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "prd-aks"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = "prd-aks"
  kubernetes_version  = var.kubernetes_version
  node_resource_group = "${azurerm_resource_group.aks-rg.name}-nrg"

default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = var.kubernetes_version
    #availability_zones   = [1, 2, 3]
    # Added June2023
    zones = [1, 2, 3]
    #enable_auto_scaling  = true # COMMENTED OCT2024
    auto_scaling_enabled = true  # ADDED OCT2024
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
    } 
   tags = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
   } 
  }

    identity {
    type = "SystemAssigned"
  }

   azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = true
    admin_group_object_ids = [azuread_group.ad.object_id]

   }  

service_mesh_profile {
    mode = "Istio"
    revisions = ["asm-1-26"]
  }

network_profile {
  network_plugin    = "kubenet"
  network_policy    = "calico"
}

lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count, # Ignore auto-scaling or manual node count changes
      tags,                             # Ignore tag changes made outside Terraform
    ]
  }

}

resource "azurerm_management_lock" "aks-lock" {
  count = var.enable_resource_lock == true ? 1 : 0

  name       = "aks-lock"
  scope      = azurerm_kubernetes_cluster.aks.id
  lock_level = "CanNotDelete"
  notes      = "Lock to prevent accidental deletion of critical resources"
}


