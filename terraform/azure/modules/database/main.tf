resource "random_string" "main" {
  length = var.length_of_username
  min_upper = var.number_of_uppercase_characters
  special = false
  lifecycle {
    ignore_changes = [
      length
    ]
  }
}

resource "random_password" "main" {
  length = var.length_of_password
  min_upper = var.number_of_uppercase_characters
  lifecycle {
    ignore_changes = [
      length
    ]
  }
}

resource "azurerm_mysql_server" "main" {
    name = "${var.environment}-mysqlentireofserver"
    location = var.resource_group_location
    resource_group_name = var.resource_group_name
    administrator_login = random_string.main.result
    administrator_login_password = random_password.main.result
    sku_name   = "B_Gen5_2"
    storage_mb = 5120
    version = "5.7"
    auto_grow_enabled                 = true
    backup_retention_days             = 7
    geo_redundant_backup_enabled      = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled     = true
    ssl_enforcement_enabled           = true
    ssl_minimal_tls_version_enforced  = "TLS1_2"
}
