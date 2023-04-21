resource "kubernetes_role_binding" "remote-rb" {
  metadata {
    name      = "my-remote-rb"
    namespace = "remote"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "eso-secret-reader"
    #namespace = "eso-demo"

  }
  subject {
    kind      = "ServiceAccount"
    name      = "my-remote-sa"
    namespace = "eso-demo"
  }
}
