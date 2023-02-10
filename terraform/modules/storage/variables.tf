variable "resource_group_name" {
  type = string
  description = "Resource group name of Dev Environment"
  default = "dev"
}

variable "resource_group_location" {
  type = string
  description = "Resource group location of Dev Environment"
  default = "southeastasia"
}

variable "environment" {
  type = string 
  description = "Enviroment name for working"
}

variable "tags" {
    type = map
    description = "Resource tags"
    default = null
}

variable "allowed_ips" {
    type = string
    description = "The ip allow access storage blob"
    sensitive = true
}

variable "blob_name" {
    type = string
    description = "Name of Blob inside Container of Storage Account"
}