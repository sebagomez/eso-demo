terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.14.0"
    }
  }
}

provider "vault" {
  address = "http://localhost:8200" # <- Make sure kubectl port-forward is running
  token   = "root"
}
