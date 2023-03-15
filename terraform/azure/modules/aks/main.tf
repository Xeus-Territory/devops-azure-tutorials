resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.environment}-k8s"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.environment}-k8s-dns"
  tags = var.tags

  node_resource_group = "${var.resource_group_name}-k8s-infra"
  automatic_channel_upgrade = var.automatic_channel_upgrade
  http_application_routing_enabled = true
  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.subnet_node_pools_id
  }

  identity {
    type = "SystemAssigned"
  }
}
