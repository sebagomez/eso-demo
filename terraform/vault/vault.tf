resource "helm_release" "vault" {
  name       = "vault"
  namespace  = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"

  create_namespace = "true"

  set {
    name  = "server.dev.enabled"
    value = "true"
  }
}
