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