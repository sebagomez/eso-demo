terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"
    }
  }
}

provider "kubernetes" {
  # Configuration from current config for minikube
  config_path    = "~/.kube/config"
  config_context = "minikube"
}
