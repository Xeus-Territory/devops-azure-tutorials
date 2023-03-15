data "azurerm_resource_group" "root"{
    name = var.resource_group_root_name
}

data "azurerm_image" "main" {
  name                = var.source_image_name
  resource_group_name = var.resource_group_root_name
}

data "azurerm_ssh_public_key" "main" {
  name                = var.ssh_public_key_name
  resource_group_name = data.azurerm_resource_group.root.name
}

data "azurerm_container_registry" "main" {
  name                = var.container_registry_name
  resource_group_name = data.azurerm_resource_group.root.name
}
