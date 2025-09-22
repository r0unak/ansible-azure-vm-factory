output "location" {
    value = azurerm_resource_group.aks-rg.location
  
}

output "name" {
    value = azurerm_resource_group.aks-rg.name
  
}

output "versions" {
  value = data.azurerm_kubernetes_service_versions.current.versions
}

output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.aks.kubernetes_version
}