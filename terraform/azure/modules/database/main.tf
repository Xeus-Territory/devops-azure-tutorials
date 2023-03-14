resource "random_string" "username" {
  length = var.length_of_username
  min_upper = var.number_of_uppercase_characters
  special = false
  lifecycle {
    ignore_changes = [
      length
    ]
  }
}

resource "random_string" "password" {
  length = var.length_of_password
  min_upper = var.number_of_uppercase_characters
  override_special = var.overide_special
  lifecycle {
    ignore_changes = [
      length
    ]
  }
}

resource "random_integer" "random" {
  min = 100000
  max = 999999
}

resource "azurerm_resource_group" "main" {
  name = "${var.environment}-DatabaseZone"
  location = var.resource_group_location
}

# Network of database 
resource "azurerm_virtual_network" "main" {
  name = "${var.environment}-vpc"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space = [ "172.16.0.0/16" ]
}

resource "azurerm_subnet" "db_subnet" {
  name = "${var.environment}-subnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name = azurerm_resource_group.main.name
  address_prefixes = [ "172.16.0.0/24" ]
  service_endpoints = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [ 
        "Microsoft.Network/virtualNetworks/subnets/join/action" 
        ]
    }
  }
}

# resource "azurerm_private_dns_zone" "main" {
#     name = "${var.environment}mysql.database.azure.com"
#     resource_group_name = azurerm_resource_group.main.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "main" {
#     name = "${var.environment}privateDNSZone.com"
#     private_dns_zone_name = azurerm_private_dns_zone.main.name
#     virtual_network_id = azurerm_virtual_network.main.id
#     resource_group_name = azurerm_resource_group.main.name
# }

# # Provision of MySQL - Single Server
# resource "azurerm_mysql_server" "main" {
#     name = "${var.environment}-mysqlentireofglobal"
#     location = var.resource_group_location
#     resource_group_name = var.resource_group_name
#     administrator_login = random_string.username.result
#     administrator_login_password = random_string.password.result
#     sku_name   = "B_Gen5_2"
#     storage_mb = 5120
#     version = "5.7"
#     auto_grow_enabled                 = true
#     backup_retention_days             = 7
#     geo_redundant_backup_enabled      = false
#     infrastructure_encryption_enabled = false
#     public_network_access_enabled     = true
#     ssl_enforcement_enabled           = true
#     ssl_minimal_tls_version_enforced  = "TLS1_2"
# }

# # Provision of MySQL - Flexible Server
# resource "azurerm_mysql_flexible_server" "main" {
#     name = "${var.environment}-flexiblemysqlenriteofglobal"
#     location = azurerm_resource_group.main.location
#     resource_group_name = azurerm_resource_group.main.name
#     administrator_login = "${var.environment}${random_string.username.result}"
#     administrator_password = "${var.environment}${random_string.password.result}"
#     backup_retention_days = 7
#     delegated_subnet_id = azurerm_subnet.main.id
#     private_dns_zone_id = azurerm_private_dns_zone.main.id
#     sku_name = "GP_Standard_D2ds_v4"
#     depends_on = [
#       azurerm_private_dns_zone_virtual_network_link.main
#     ]
#     storage {
#       auto_grow_enabled = true
#       iops = 360
#       size_gb = 20
#     }
# }

# resource "azurerm_mysql_flexible_server_firewall_rule" "main" {
#     name = "${var.environment}-allowedIP"
#     resource_group_name = azurerm_resource_group.main.name
#     server_name = azurerm_mysql_flexible_server.main.name
#     start_ip_address = var.allowed_ips
#     end_ip_address = var.allowed_ips
# }

# Provision CosmoDB - MongoDB type
resource "azurerm_cosmosdb_account" "main" {
    name = "${var.environment}-cosmosdb-${random_integer.random.result}"
    location = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    offer_type = "Standard"
    kind = "GlobalDocumentDB"
    enable_automatic_failover = false
    
    geo_location {
      location = azurerm_resource_group.main.location
      failover_priority = 0
    }

    consistency_policy {
      consistency_level = "BoundedStaleness"
      max_interval_in_seconds = 100
      max_staleness_prefix = 10000
    }

    depends_on = [
      azurerm_resource_group.main
    ]
}

resource "azurerm_cosmosdb_sql_database" "main" {
  name = "${var.environment}-cosmosdb-database-${random_integer.random.result}"
  resource_group_name = azurerm_resource_group.main.name
  account_name = azurerm_cosmosdb_account.main.name
  autoscale_settings {
    max_throughput = 1000
  }
}

resource "azurerm_cosmosdb_sql_container" "main" {
  name = "${var.environment}-cosmosdb-container-${random_integer.random.result}"
  resource_group_name = azurerm_resource_group.main.name
  account_name = azurerm_cosmosdb_account.main.name
  database_name = azurerm_cosmosdb_sql_database.main.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  autoscale_settings {
    max_throughput = 1000
  }

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }
  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
