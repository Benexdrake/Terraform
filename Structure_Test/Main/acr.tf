resource "azurerm_container_registry" "main" {
  name                      = "${var.application_name}"
  resource_group_name       = data.azurerm_resource_group.main.name
  location                  = data.azurerm_resource_group.main.location
  sku                       = "Standard"
  admin_enabled             = true
  anonymous_pull_enabled    = true
}