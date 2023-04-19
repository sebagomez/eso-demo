
resource "azurerm_key_vault" "eso-key-vault" {
  name                        = "eso-key-vault"
  location                    = azurerm_resource_group.eso-demo.location
  resource_group_name         = azurerm_resource_group.eso-demo.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create"
    ]

    secret_permissions = [
      "Set", "Get", "Delete", "Purge", "Recover"
    ]
  }
}

