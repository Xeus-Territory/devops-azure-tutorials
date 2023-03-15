#Get the resource backend from the Private Storage backend
terraform {
  backend "azurerm" {
      resource_group_name = var.resourceGroup
      storage_account_name = var.storageAccount
      container_name = var.storageContainer
      key = var.storageBlob
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

provider "helm" {
    kubernetes {
        host = data.azurerm_kubernetes_cluster.main.kube_config.0.host
        cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)
        client_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)
        client_key = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_key)
    } 
}

provider "kubernetes" {
    host = data.azurerm_kubernetes_cluster.main.kube_config.0.host
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)
    client_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)
    client_key = base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_key)
}