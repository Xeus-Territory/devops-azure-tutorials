resource "azurerm_bastion_host" "main" {
    name = "${local.environment}-bastionHost"
    location = data.azurerm_resource_group.main.location
    resource_group_name = data.azurerm_resource_group.main.name

    ip_configuration {
      name = "${local.environment}-bastionConfiguration"
      subnet_id = azurerm_subnet.bastion_subnet.id
      public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
    }
}