variable "environment" {
  type = string
  description = "Environment type for Infra"
}

variable "resource_group_name" {
  type = string
  description = "resource group name for module"
}

variable "location_of_resource" {
  type = string
  description = "Place where resource take in"
}

variable "type_plan" {
  type = string
  description = "Type of OS using service plan"
}

variable "sku_name" {
  type = string
  description = "sku for service plan"
}

variable "storage_account_name" {
  type = string
  description = "storage account name for storage service plan"
}

variable "sa_access_key" {
  type = string
  description = "access_key_to_blob"
  sensitive = true
}