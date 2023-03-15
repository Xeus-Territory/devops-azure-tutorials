variable "resource_group_name" {
  type        = string
  description = "Resource group name of Dev Environment"
  default     = "dev"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location of Dev Environment"
  default     = "southeastasia"
}

variable "source_image_id" {
  type        = string 
  description = "ID of Linux Image"
}

variable "ssh_public_key_name" {
  type        = string
  description = "Public SSH Key"
}

variable "user_identity_id"{
  type        = string 
  description = "ID of User Identity"
}

variable "subnet_id" {
  type        = string
  description = "ID of Subnet in Virtual Network"
}

variable "application_security_group_ids" {
  type        = string
  description = "ID of Application Security Group"
}

variable "load_balancer_backend_address_pool_ids" {
  type        = string
  description = "ID of Load Balancer Address Pool"
}

variable "container_registry_name" {
  type        = string
  description = "Name of Container Registry"
}

variable "storage_account_name" {
  type        = string 
  description = "Name of Storage Account for App"
}

variable "storage_container_name" {
  type        = string 
  description = "Name of Storage Container for App"
}

variable "storage_blob_name" {
  type        = string 
  description = "Name of Storage Blob for App"
}

variable "environment" {
  type        = string 
  description = "Enviroment name for working"
}

variable "tags" {
  type        = map
  description = "Resource tags"
  default     = null
}

variable "custom_emails" {
  type        = string 
  description = "Custom Email to receive notification"
  default     = "nguyen.nguyenhoaibao@orientsoftware.com"
}

variable "sku" {
  type = string
  description = "sku for vmss"
  default = "Standard_B1s"
}

variable "admin_username" {
  type = string
  description = "username of admin in VM"
  default = "intern"
}

variable "user_name_for_ssh" {
  type = string
  description = "username of ssh into VM"
  default = "intern"
}

variable "caching" {
  type = string
  description = "caching stype for VM"
  default = "ReadWrite"
}

variable "storage_account_type" {
  type = string
  description = "storage account type for VM"
  default = "StandardSSD_LRS"
}

variable "number_of_instances" {
  type = number
  description = "number of instances"
  default = 1
}