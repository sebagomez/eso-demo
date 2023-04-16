resource "vault_kv_secret_v2" "secret-one" {
  mount               = "secret"
  name                = "secret-one"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      the-key = "Hello from Vault"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      dev      = "seb",
      provider = "Hashicrop Vault"
      example  = "External Secrets Operator"
    }
  }
}

resource "vault_kv_secret_v2" "secret-two" {
  mount               = "secret"
  name                = "secret-two"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      different-key = "A new secret"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      dev      = "sebastian",
      provider = "Hashicrop Vault"
      example  = "ESO"
    }
  }
}

resource "vault_kv_secret_v2" "three" {
  mount               = "secret"
  name                = "three"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      key = "Third secret value"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      dev      = "seb",
      provider = "Hashicrop Vault"
      example  = "ESO"
    }
  }
}
