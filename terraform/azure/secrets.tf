resource "azurerm_key_vault_secret" "secret-one" {
  name = "secret-one"
  value = jsonencode({
    the-key = "Hello from Azure Key Vault"
  })
  key_vault_id = azurerm_key_vault.eso-key-vault.id
  tags = {
    dev      = "seb"
    provider = "Azure Key Vault"
    example  = "External Secrets Operator"
  }
}

resource "azurerm_key_vault_secret" "secret-two" {
  name = "secret-two"
  value = jsonencode({
    different-key = "A new Azure Key Vault secret"
  })
  key_vault_id = azurerm_key_vault.eso-key-vault.id
  tags = {
    dev      = "sebastian"
    provider = "Azure Key Vault"
    example  = "ESO"
  }
}

resource "azurerm_key_vault_secret" "three" {
  name = "three"
  value = jsonencode({
    key = "Third Azure Key Vault secret"
  })
  key_vault_id = azurerm_key_vault.eso-key-vault.id
  tags = {
    dev      = "seb"
    provider = "Azure Key Vault"
    example  = "ESO"
  }
}

resource "azurerm_key_vault_secret" "access-key" {
  name = "access-key"
  value = jsonencode({
    id     = "AKIAIOSFODNN7EXAMPLE"
    secret = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  })
  key_vault_id = azurerm_key_vault.eso-key-vault.id
  tags = {
    dev      = "sebastian"
    provider = "Azure Key Vault"
    example  = "External Secrets Operator"
  }
}
