# Create a VM scale set manutally
resource "azurerm_linux_virtual_machine_scale_set" "main" {
    name = "${local.environment}-vmss"
    resource_group_name = data.azurerm_resource_group.main.name
    location = data.azurerm_resource_group.main.location
    sku = "Standard_B1s"
    instances = 1
    admin_username = "intern"

    admin_ssh_key {
        username = "intern"
        public_key = data.azurerm_ssh_public_key.main.public_key
    }

    os_disk {
        storage_account_type = "StandardSSD_LRS"
        caching = "ReadWrite"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    network_interface {
        name = "${local.environment}-nic"
        primary = true
      ip_configuration {
        name = "internal"
        primary = true
        subnet_id = data.azurerm_subnet.main.id
        load_balancer_backend_address_pool_ids = [ data.azurerm_lb_backend_address_pool.main.id ]
        application_security_group_ids = [ data.azurerm_application_security_group.main.id ]
      }
    }

    disable_password_authentication = true

    identity {
      type = "UserAssigned"
      identity_ids = [ data.azurerm_user_assigned_identity.main.id ]
    }

    lifecycle {
      ignore_changes = [ instances ]
    }

    user_data = base64encode(templatefile("${abspath(path.root)}/data/userdata.sh", { bucketname = var.bucket_name}))

    tags = local.common_tags
}