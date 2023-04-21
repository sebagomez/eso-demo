resource "kubernetes_service_account" "remote-sa" {
  metadata {
    name      = "my-remote-sa"
    namespace = "eso-demo"
  }
}
