resource "azurerm_service_plan" "main" {
    name = "${var.environment}-${var.type_plan}servicePlan"
    resource_group_name = var.resource_group_name
    location = var.location_of_resource
    os_type = var.type_plan
    sku_name = var.sku_name
}

resource "azurerm_linux_function_app" "main" {
    name = "${var.environment}-${var.type_plan}FuncApp"
    resource_group_name = var.resource_group_name
    location = var.location_of_resource
    storage_account_name = var.storage_account_name
    storage_account_access_key = var.sa_access_key
    service_plan_id = azurerm_service_plan.main.id
    site_config {}
}