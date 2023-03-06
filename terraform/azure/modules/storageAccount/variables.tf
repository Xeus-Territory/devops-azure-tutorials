# variable "resource_group_name" {
#   type        = string
#   description = "Resource group name of Dev Environment"
# }

# variable "resource_group_location" {
#   type        = string
#   description = "Resource group location of Dev Environment"
# }

# variable "environment" {
#   type        = string 
#   description = "Enviroment name for working"
# }

# variable "tags" {
#   type        = map
#   description = "Resource tags"
#   default     = null
# }

# variable "allowed_ips" {
#   type        = string
#   description = "The ip allow access storage blob"
#   sensitive   = true
# }

# variable "subnet_id" {
#   type        = string
#   description = "ID of Subnet in Virtual Network"
# }

# variable "blob_name" {
#   type        = string
#   description = "Name of Blob inside Container of Storage Account"
# }

# variable "time_to_keep_object" {
#   type = number
#   description = "The days to keep the object in the container"
# }

# variable "time_to_keep_version_object" {
#   type = number
#   description = "The days to keep the version of the object in the container"
# }

variable "storage_account_name" {
  type = string 
  description = "Name of Storage Account"
}