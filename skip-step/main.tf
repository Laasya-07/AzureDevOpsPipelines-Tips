terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  version = ">=2.0"
  # The "feature" block is required for AzureRM provider 2.x.
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "resourcegroup-tfstate"
  location = "westeurope"
}

resource "azurerm_storage_account" "strg" {
  name                     = "terraformtfstateskip1"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "cont" {
  name                  = "tfstate1"
  storage_account_name  = azurerm_storage_account.strg.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "blobobject" {
   name = "tfstate"
   resource_group_name = azurerm_resource_group.rg.name
   storage_account_name = azurerm_storage_account.strg.name
   storage_container_name = azurerm_storage_container.cont.name
}
