terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.52.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.37.1"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {

}

data "azurerm_client_config" "current" {}
