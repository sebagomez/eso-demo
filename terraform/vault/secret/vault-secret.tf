resource "vault_kv_secret_v2" "vault-secret" {
  mount               = "secret"
  name                = "my-secret"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      the-key = "Hello from Hashicorp Vault!"
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
