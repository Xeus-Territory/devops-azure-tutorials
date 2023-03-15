output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "storage_container_name" {
  value = azurerm_storage_container.main.name
}

output "storage_blob_name" {
  value = azurerm_storage_blob.main.name
}