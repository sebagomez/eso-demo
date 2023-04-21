resource "kubernetes_secret" "secret-one" {
  metadata {
    name      = "secret-one"
    namespace = "remote-cluster"
    labels = {
      dev      = "seb"
      provider = "Kubernetes"
      example  = "ExternalSecretsOperator"
    }
  }

  data = {
    the-key = "Hello from a Kubernetes secret"
  }
}

resource "kubernetes_secret" "secret-two" {
  metadata {
    name      = "secret-two"
    namespace = "remote-cluster"
    labels = {
      dev      = "sebastian"
      provider = "Kubernetes"
      example  = "ESO"
    }
  }

  data = {
    different-key = "A new Kubernetes secret"
  }
}

resource "kubernetes_secret" "three" {
  metadata {
    name      = "three"
    namespace = "remote-cluster"
    labels = {
      dev      = "seb"
      provider = "Kubernetes"
      example  = "ESO"
    }
  }

  data = {
    key = "Third Kubernetes secret"
  }
}
