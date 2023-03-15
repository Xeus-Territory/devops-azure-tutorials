variable "resource_group_name" {
  type = string
  description = "Resource group name of Dev Environment"
}

variable "resource_group_location" {
  type = string
  description = "Resource group location of Dev Environment"
}

variable "environment" {
  type = string 
  description = "Enviroment name for working"
}

variable "tags" {
  type = map
  description = "Resource tags"
}

variable "address_space" {
  type = list(string)
  description = "Address space of Network"
}

variable "address_prefixes" {
  type = list(string)
  description = "Address prefixs of Subnet"  
}

variable "service_endpoints" {
  type = list(string)
  description = "Service endpoints of subnet"
  default = [ "Microsoft.Storage" ]
}
