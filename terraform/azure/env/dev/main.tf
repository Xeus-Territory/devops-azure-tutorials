# # Move the azure for new resource 
resource "azurerm_resource_group" "main" {
  name        = var.resource_group_name
  location    = var.resource_group_location
  tags        = var.tags
}

# # This part is once of release v0.0.2

module "network" {
  count = var.condition_variable == "aks" ? 1 : 0
  source = "../../modules/networking"
  resource_group_name = azurerm_resource_group.main.name
  resource_group_location = azurerm_resource_group.main.location
  environment = var.environment
  tags = var.tags
  address_space = var.address_space
  address_prefixes = var.address_prefixes
}

module "aks" {
    count = var.condition_variable == "aks" ? 1 : 0
    source = "../../modules/aks"    
    resource_group_name                     = azurerm_resource_group.main.name
    resource_group_location                 = azurerm_resource_group.main.location    
    environment                             = var.environment
    subnet_node_pools_id = module.network[0] != null ? module.network[0].subnet_id : ""
    tags                                    = var.tags
    depends_on = [
      module.network
    ]
}

module "iam" {
    count = var.condition_variable == "aks" ? 1 : 0
    source = "../../modules/iam"
    resource_group_root_id = data.azurerm_resource_group.root.id
    container_registry_id = data.azurerm_container_registry.main.id
    storage_account_id = data.azurerm_storage_account.main.id 
    principal_id = module.aks[0] != null ? module.aks[0].principal_id : ""
    cluster_id  = module.aks[0] != null ? module.aks[0].cluster_id : ""
    depends_on = [
      module.aks
    ]
}

module "storage" {
  count = var.condition_variable == "aks" ? 1 : 0
  source = "../../modules/storageAccount"
  storage_account_name = data.azurerm_storage_account.main.name
  depends_on = [
    module.aks
  ]
}

module "database" {
  count = ((var.condition_variable != "serverless") && (var.condition_variable != "aks")) ? 1 : 0
  source = "../../modules/database"
  environment = var.environment
  email_alert = var.email_alert
  number_of_uppercase_characters = var.number_of_uppercase_characters
  number_of_special_characters = var.number_of_special_characters
  length_of_username = var.length_of_username
  length_of_password = var.length_of_password
  overide_special = var.overide_special
  allowed_ips = var.allowed_ips
}

module "serverless" {
  count = var.condition_variable == "serverless" ? 1 : 0
  source = "../../modules/serverless"
  environment = var.environment
  resource_group_name = var.resource_group_name
  location_of_resource = var.resource_group_location
  type_plan = "Linux"
  sku_name = "Y1"
  storage_account_name = var.storage_account_name
  sa_access_key = data.azurerm_storage_account.main.primary_access_key
  depends_on = [
    azurerm_resource_group.main
  ]
}

# # This part is once of release v0.0.2

# # This part is once of release v0.0.1

# module "iam" {
#     source                  = "../modules/iam"
#     resource_group_root_id  = data.azurerm_resource_group.root.id
#     resource_group_id       = azurerm_resource_group.main.id
#     resource_group_name     = azurerm_resource_group.main.name
#     resource_group_location = azurerm_resource_group.main.location
#     # cluster_pricipal_id     = module.aks.cluster_pricipal_id
#     environment             = var.environment
#     tags                    = var.tags
# }

# module "network" {
#     source                  = "../modules/networking"
#     resource_group_name     = azurerm_resource_group.main.name
#     resource_group_location = azurerm_resource_group.main.location
#     environment             = var.environment
#     tags                    = var.tags
#     depends_on = [
#       module.iam
#     ]
# }

# module "balancer" {
#     source = "../modules/loadBalancer"
#     resource_group_name     = azurerm_resource_group.main.name
#     resource_group_location = azurerm_resource_group.main.location    
#     environment             = var.environment
#     tags                    = var.tags
#     depends_on = [
#       module.network
#     ]
# }

# module "storage" {
#     source                  = "../modules/storageAccount"
#     resource_group_name     = azurerm_resource_group.main.name
#     resource_group_location = azurerm_resource_group.main.location   
#     subnet_id               = module.network.subnet_id
#     allowed_ips             = var.allowed_ips
#     blob_name               = var.blob_name
#     environment             = var.environment
#     tags                    = var.tags
#     depends_on = [
#       module.balancer
#     ]
# }

# module "vmss" {
#     source                                  = "../modules/vmss" 
#     resource_group_name                     = azurerm_resource_group.main.name
#     resource_group_location                 = azurerm_resource_group.main.location   
#     source_image_id                         = data.azurerm_image.main.id
#     ssh_public_key_name                     = data.azurerm_ssh_public_key.main.public_key
#     container_registry_name                 = data.azurerm_container_registry.main.name
#     user_identity_id                        = module.iam.user_identity_id
#     subnet_id                               = module.network.subnet_id
#     application_security_group_ids          = module.network.application_security_group_ids
#     load_balancer_backend_address_pool_ids  = module.balancer.load_balancer_backend_address_pool_ids
#     storage_account_name                    = module.storage.storage_account_name
#     storage_container_name                  = module.storage.storage_container_name
#     storage_blob_name                       = module.storage.storage_blob_name
#     environment                             = var.environment
#     tags                                    = var.tags
#     depends_on = [
#         module.storage
#     ]
# }

# # This part is once of release v0.0.1
