output "subnet_id" {
  value = azurerm_subnet.main.id
}

output "application_security_group_ids" {
  value = azurerm_application_security_group.main.id
}