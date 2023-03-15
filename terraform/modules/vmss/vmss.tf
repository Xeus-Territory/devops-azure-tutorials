
# Create a Linux Virtual Machine Scale sets
resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                  = "${var.environment}-vmss"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  sku                   = "Standard_B1s"
  instances             = 1
  admin_username        = "intern"

  source_image_id = var.source_image_id

  admin_ssh_key {
    username   = "intern"
    public_key = var.ssh_public_key_name
  }
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [var.user_identity_id]
  }

  network_interface {
    name      = "${var.environment}-vmss-network"
    primary   = true
    ip_configuration {
      name                                    = "internal"
      primary                                 = true
      subnet_id                               = var.subnet_id
      load_balancer_backend_address_pool_ids  = [ var.load_balancer_backend_address_pool_ids ]
      application_security_group_ids          = [ var.application_security_group_ids ] 
    }
  }

  extension {
    name                 = "${var.environment}-vmExtension"
    publisher            = "Microsoft.Azure.Extensions"
    type                 = "CustomScript"
    type_handler_version = "2.0"

    settings = jsonencode({
      "script": "${base64encode("${templatefile("${abspath(path.module)}/data/startup.tpl",{
    "containerRegistry_main"  = var.container_registry_name
    "storageAccount_web"      = var.storage_account_name
    "storageContainer_web"    = var.storage_container_name
    "storageBlob_web"         = var.storage_blob_name
})}")}"
    })
  }

  disable_password_authentication = true
  tags                            = var.tags
}