data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_network_interface" "public_dashboard" {
  name = "nic-${var.application_name}-${var.environment_name}-public-dashboard"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_public_ip" "dashboard" {
  name = "pip-${var.application_name}-${var.environment_name}-dashboard"
  resource_group_name = data.azurerm_resource_group.main.name
}