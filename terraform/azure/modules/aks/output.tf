output "principal_id" {
  value = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  sensitive = true
}

output "cluster_id" {
  value = azurerm_kubernetes_cluster.main.identity[0].principal_id
  sensitive = true
}