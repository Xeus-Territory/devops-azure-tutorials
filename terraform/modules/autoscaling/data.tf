data "azurerm_resource_group" "main"{
    name = "DevOpsIntern"
}

data "azurerm_ssh_public_key" "main" {
    name = "DevOpsIntern"
    resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_user_assigned_identity" "main" {
    name = "${local.environment}-identityforVM"
    resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_subnet" "main" {
    name = "${local.environment}-subnet"
    virtual_network_name = "${local.environment}-network"
    resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_lb" "main" {
    name = "${local.environment}-LoadBalancer"
    resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_lb_backend_address_pool" "main" {
    name = "${local.environment}-backendlbConfiguration"
    loadbalancer_id = data.azurerm_lb.main.id
}

data "azurerm_application_security_group" "main" {
    name = "${local.environment}-asg"
    resource_group_name = data.azurerm_resource_group.main.name
}
