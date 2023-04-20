resource "azuread_application" "eso-app" {
  display_name = "External Sectret Demo App"
  owners       = [data.azurerm_client_config.current.object_id]
  #logo_image       = filebase64("/path/to/logo.png")
}

resource "azuread_service_principal" "eso-app" {
  application_id               = azuread_application.eso-app.application_id
  app_role_assignment_required = false
  owners                       = [data.azurerm_client_config.current.object_id]
  feature_tags {
    enterprise = true
    gallery    = true
  }
}

resource "azuread_application_password" "app-password" {
  application_object_id = azuread_application.eso-app.object_id
  display_name          = "App Password"
}
