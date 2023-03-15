# resource "azurerm_storage_account" "main" {
#   name                     = "${var.environment}orientdnintern"
#   resource_group_name      = var.resource_group_name
#   location                 = var.resource_group_location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   public_network_access_enabled = true

#   network_rules {
#       default_action              = "Deny"
#       ip_rules                    = [var.allowed_ips]
#   }

#   blob_properties {
#     versioning_enabled = true
#   }
#   tags = var.tags
# }

# resource "azurerm_storage_encryption_scope" "main" {
#   name = "${var.environment}encryptionScope"
#   source = "Microsoft.Storage"
#   storage_account_id = azurerm_storage_account.main.id
# }

# resource "azurerm_storage_container" "main" {
#   name                  = "${var.environment}-data"
#   storage_account_name  = azurerm_storage_account.main.name
#   container_access_type = "private"
# }

# resource "azurerm_storage_blob" "main" {
#   name                   = "${var.environment}-blob-web"
#   storage_account_name   = azurerm_storage_account.main.name
#   storage_container_name = azurerm_storage_container.main.name
#   type                   = "Block"
#   source                 = "${dirname(dirname(dirname(dirname(abspath(path.root)))))}/${var.blob_name}"
# }

# resource "azurerm_storage_management_policy" "main" {
#   storage_account_id = azurerm_storage_account.main.id

#   rule {
#     name = "${var.environment}-storageManagementPolicy"
#     enabled = true
#     filters {
#       blob_types = [ "blockBlob" ]
#       prefix_match = [ "${azurerm_storage_container.main.name}/${azurerm_storage_blob.main.name}" ]
#     }

#     actions {
#       base_blob {
#         delete_after_days_since_modification_greater_than = var.time_to_keep_object
#       }

#       version {
#         delete_after_days_since_creation = var.time_to_keep_version_object
#       }
#     }
#   }
# }

resource "azurerm_storage_share" "main" {
  name                 = "nginx"
  storage_account_name = var.storage_account_name
  quota                = 1
}

resource "azurerm_storage_share_file" "main" {
  name             = "default.conf"
  storage_share_id = azurerm_storage_share.main.id
  source           = "${abspath(path.module)}/data/nginx.conf"
}
