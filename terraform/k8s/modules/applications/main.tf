resource "kubernetes_namespace" "deployment" {
    metadata {
      name = var.metadata-namespace
    }
}

resource "helm_release" "rbac" {
    name = "rbac"
    namespace = kubernetes_namespace.deployment.metadata[0].name
    chart = "${dirname(dirname(dirname(dirname(abspath(path.module)))))}/kubernetes/rbac/"
    depends_on = [
      kubernetes_namespace.deployment
    ]
}

resource "helm_release" "app1" {
    name = "app1"
    namespace = kubernetes_namespace.deployment.metadata[0].name
    chart = "${dirname(dirname(dirname(dirname(abspath(path.module)))))}/kubernetes/app1/"
    depends_on = [
      helm_release.rbac
    ]
}

resource "helm_release" "app2" {
    name = "app2"
    namespace = kubernetes_namespace.deployment.metadata[0].name
    chart = "${dirname(dirname(dirname(dirname(abspath(path.module)))))}/kubernetes/app2/"
    depends_on = [
      helm_release.rbac
    ]
}

resource "helm_release" "app3" {
    name = "app3"
    namespace = kubernetes_namespace.deployment.metadata[0].name
    chart = "${dirname(dirname(dirname(dirname(abspath(path.module)))))}/kubernetes/app3/"
    depends_on = [
      helm_release.rbac
    ]
}

resource "helm_release" "app4" {
    name = "app4"
    namespace = kubernetes_namespace.deployment.metadata[0].name    
    chart = "${dirname(dirname(dirname(dirname(abspath(path.module)))))}/kubernetes/app4/"
    depends_on = [
      helm_release.rbac
    ]
}

resource "helm_release" "nginx" {
    name = "web-server"
    namespace = kubernetes_namespace.deployment.metadata[0].name
    chart = "${dirname(dirname(dirname(dirname(abspath(path.module)))))}/kubernetes/nginx-persistent/"
    depends_on = [
      helm_release.app1, helm_release.app2, helm_release.app3, helm_release.app4, kubernetes_namespace.deployment
    ]
}

resource "helm_release" "common" {
    name = "nginx-host"
    namespace = kubernetes_namespace.deployment.metadata[0].name
    chart = "${dirname(dirname(dirname(dirname(abspath(path.module)))))}/kubernetes/common/"
    depends_on = [
      helm_release.app1, helm_release.app2, helm_release.app3, helm_release.app4, helm_release.nginx, kubernetes_namespace.deployment
    ]
}
