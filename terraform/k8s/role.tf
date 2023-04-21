resource "kubernetes_role" "eso-secret-reader" {
  metadata {
    name      = "eso-secret-reader"
    namespace = "remote"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "watch"]
  }
}
