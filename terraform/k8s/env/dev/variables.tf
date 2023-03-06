variable "cluster_name" {
    type = string
    description = "Name of the cluster"
    default = "dev-k8s"
}

variable "cluster_resource_group" {
    type = string
    description = "Where the cluster is existence"
    default = "dev-environment"
}

variable "namespace_deployment" {
    type = string
    description = "namespace for k8s deployment part"
}

variable "namespace_ingress" {
    type = string
    description = "Namespace for k8s common part"
}

variable "namespace_monitoring" {
    type = string
    description = "Monitoring for k8s monitoring part"
}