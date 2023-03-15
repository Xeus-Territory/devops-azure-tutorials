resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.metadata-namespace
  }
}

resource "helm_release" "loki" {
  name       = "loki-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  depends_on = [
    kubernetes_namespace.monitoring
  ]
}

resource "helm_release" "tempo" {
  name = "tempo-stack"
  namespace = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "tempo"
  depends_on = [
    kubernetes_namespace.monitoring
  ]  
}

resource "helm_release" "prometheus" {
  name       = "prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [
    <<EOF
        kubeEtcd:
          enabled: false
        kubeControllerManager:
          enabled: false
        kubeScheduler:
          enabled: false
        kubeProxy:
          enabled: false
        alertmanager:
          alertmanagerSpec:
            storage:
              volumeClaimTemplate:
                spec:
                  storageClassName: alert-data
                  accessModes: ["ReadWriteOnce"]
                  resources:
                    requests:
                      storage: 1Gi
        
        prometheus:
          prometheusSpec:
            storageSpec:
              volumeClaimTemplate:
                spec:
                  storageClassName: prometheus-data
                  accessModes: ["ReadWriteOnce"]
                  resources:
                    requests:
                      storage: 1Gi
        grafana:
          ingress:
            enabled: true
            ingressClassName: nginx
          persistence:
            enabled: true
          additionalDataSources:
          - name: Loki
            type: loki
            uid: loki-stack
            url: http://loki-stack:3100/
            access: proxy
            isDefault: false 
          - name: Tempo
            type: tempo
            uid: tempo-stack
            url: http://tempo-stack:3100/
            access: proxy
            isDefault: false
      EOF
  ]

  depends_on = [
    kubernetes_namespace.monitoring, helm_release.loki, helm_release.tempo
  ]
}
