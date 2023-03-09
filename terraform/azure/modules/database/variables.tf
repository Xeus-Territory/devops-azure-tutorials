variable "number_of_uppercase_characters" {
  type = number
  sensitive = true
  description = "number of characters in the string"
}

variable "number_of_special_characters" {
    type = number
    sensitive = true
    description = "number of special characters in the string"
}

variable "length_of_username" {
    type = number
    sensitive = true
    description = "length of the username"
}

variable "length_of_password" {
    type = number
    sensitive = true
    description = "length of the password"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name of Dev Environment"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location of Dev Environment"
}

variable "environment" {
  type = string
  description = "Environment of Resource Group"
}

variable "email_alert" {
  type = string
  description = "Email using for alert thread of Database"
}

variable "overide_special" {
  type = string
  description = "Special character used"
}

variable "allowed_ips" {
  type        = string
  description = "The ip allow access storage blob"
  sensitive   = true
}