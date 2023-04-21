resource "kubernetes_role" "eso-secret-reader" {
  metadata {
    name      = "eso-secret-reader"
    namespace = "remote-cluster"
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["authorization.k8s.io"]
    resources  = ["selfsubjectrulesreviews"]
    verbs      = ["create"]
  }
}
