data "azurerm_kubernetes_cluster" "main" {
    name = var.cluster_name
    resource_group_name = var.cluster_resource_group
}