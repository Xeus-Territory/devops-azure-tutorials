resource "kubernetes_namespace" "ingress" {
    metadata {
      name = var.metadata-namespace
    }
}

resource "helm_release" "nginx-ingress-controller" {
  name = "nginx-ingress-controller"
  namespace = kubernetes_namespace.ingress.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name = "scope.namespace"
    value = var.metadata-namespace
  }

  depends_on = [
    kubernetes_namespace.ingress
  ]
}
