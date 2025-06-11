data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_network_interface" "public_dashboard" {
  name = "nic-${var.application_name}-${var.environment_name}-public-dashboard"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_network_interface" "public_gateway" {
  name = "nic-${var.application_name}-${var.environment_name}-public-gateway"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_network_interface" "private" {
  name = "nic-${var.application_name}-${var.environment_name}-private"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_public_ip" "dashboard" {
  name = "pip-${var.application_name}-${var.environment_name}-dashboard"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_public_ip" "gateway" {
  name = "pip-${var.application_name}-${var.environment_name}-gateway"
  resource_group_name = data.azurerm_resource_group.main.name
}