variable "email_notification" {
    description = "Email notification for action autoscale"
    type = string 
    sensitive = true
}

variable "bucket_name" {
    type = string
    description = "Name of the bucket to create"
}