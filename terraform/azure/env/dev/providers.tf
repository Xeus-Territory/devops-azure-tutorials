#Get the resource backend from the Private Storage backend
terraform {
  backend "azurerm" {
      resource_group_name = var.resourceGroup
      storage_account_name = var.storageAccount
      container_name = var.storageContainer
      key = var.storageBlob
  }
  required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.43.0"
      }
  }
}
provider "azurerm" {
  features{}
}

