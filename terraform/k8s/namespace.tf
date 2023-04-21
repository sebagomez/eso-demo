resource "kubernetes_namespace" "remote" {
  metadata {
    name = "remote"
  }
}
