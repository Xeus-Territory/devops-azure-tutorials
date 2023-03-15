# Move the azure for new resource
resource "azurerm_resource_group" "main" {
  name        = var.resource_group_name
  location    = var.resource_group_location
  tags        = var.tags
}

module "iam" {
    source                  = "../modules/iam"
    resource_group_root_id  = data.azurerm_resource_group.root.id
    resource_group_id       = azurerm_resource_group.main.id
    resource_group_name     = azurerm_resource_group.main.name
    resource_group_location = azurerm_resource_group.main.location
    environment             = var.environment
    tags                    = var.tags
}

module "network" {
    source                  = "../modules/networking"
    resource_group_name     = azurerm_resource_group.main.name
    resource_group_location = azurerm_resource_group.main.location
    environment             = var.environment
    tags                    = var.tags
    depends_on = [
      module.iam
    ]
}

module "balancer" {
    source = "../modules/loadBalancer"
    resource_group_name     = azurerm_resource_group.main.name
    resource_group_location = azurerm_resource_group.main.location    
    environment             = var.environment
    tags                    = var.tags
    depends_on = [
      module.network
    ]
}

module "storage" {
    source                  = "../modules/storage"
    resource_group_name     = azurerm_resource_group.main.name
    resource_group_location = azurerm_resource_group.main.location   
    subnet_id               = module.network.subnet_id
    allowed_ips             = var.allowed_ips
    blob_name               = var.blob_name
    environment             = var.environment
    tags                    = var.tags
    depends_on = [
      module.balancer
    ]
}

module "vmss" {
    source                                  = "../modules/vmss" 
    resource_group_name                     = azurerm_resource_group.main.name
    resource_group_location                 = azurerm_resource_group.main.location   
    source_image_id                         = data.azurerm_image.main.id
    ssh_public_key_name                     = data.azurerm_ssh_public_key.main.public_key
    container_registry_name                 = data.azurerm_container_registry.main.name
    user_identity_id                        = module.iam.user_identity_id
    subnet_id                               = module.network.subnet_id
    application_security_group_ids          = module.network.application_security_group_ids
    load_balancer_backend_address_pool_ids  = module.balancer.load_balancer_backend_address_pool_ids
    storage_account_name                    = module.storage.storage_account_name
    storage_container_name                  = module.storage.storage_container_name
    storage_blob_name                       = module.storage.storage_blob_name
    environment                             = var.environment
    tags                                    = var.tags
    depends_on = [
        module.storage
    ]
}