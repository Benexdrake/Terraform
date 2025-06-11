data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_mssql_server" "main" {
    name                = "${var.application_name}-sqlserver"
    resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_network_interface" "public" {
  name = "nic-${var.application_name}-${var.environment_name}-public"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_network_interface" "private" {
  name = "nic-${var.application_name}-${var.environment_name}-private"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_public_ip" "public" {
  name = "pip-${var.application_name}-${var.environment_name}-alpha"
  resource_group_name = var.resource_group_name
}