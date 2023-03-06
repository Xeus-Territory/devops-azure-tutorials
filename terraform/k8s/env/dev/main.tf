module "ingress-controller" {
    source = "../../modules/ingress-controller"
    metadata-namespace = var.namespace_ingress
}

module "applications" {
    source = "../../modules/applications"
    metadata-namespace = var.namespace_deployment
    depends_on = [
      module.ingress-controller
    ]
}

module "monitorings" {
    source = "../../modules/monitoring"
    metadata-namespace = var.namespace_monitoring
    depends_on = [
      module.ingress-controller
    ]
}