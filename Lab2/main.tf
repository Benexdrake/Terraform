// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

// https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations

// creates a resource group
resource "azurerm_resource_group" "main" {
  name      = "rg-${var.application_name}-${var.environment_name}"
  location  = var.primary_location
}

// creates a random string
resource "random_string" "suffix" {
  length    = 10
  upper     = false
  special   = false
}

// creates a storage account
resource "azurerm_storage_account" "main" {
  name                     = "st${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

// creates a storage container blob for tfstates
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}