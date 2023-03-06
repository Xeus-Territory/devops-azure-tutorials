#Get the resource backend from the Private Storage backend
terraform {
  backend "azurerm" {
      resource_group_name = "DevOpsIntern"
      storage_account_name = "orientdevopsintern"
      container_name = "tfstate"
      key = "storage.tfstate"
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