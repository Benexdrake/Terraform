data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Virtuelles Netzwerk (VNet) erstellen
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = var.vnet_address_space
}

# Subnetz für Container Apps erstellen und delegieren
resource "azurerm_subnet" "container_app" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet("10.0.0.0/16", 2, 0)]

  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

# Log Analytics Workspace erstellen (erforderlich für Container App Environment)
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.resource_group_name}-log-analytics"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Container App Environment erstellen und mit VNet integrieren
resource "azurerm_container_app_environment" "main" {
  name                       = var.container_app_env_name
  location                   = data.azurerm_resource_group.main.location
  resource_group_name        = data.azurerm_resource_group.main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  infrastructure_subnet_id     = azurerm_subnet.container_app.id
  internal_load_balancer_enabled = true
  
  workload_profile {
    name               = "general-apps"
    workload_profile_type = "D4"
    minimum_count      = 1
    maximum_count      = 3
  }
}

# Container App erstellen
resource "azurerm_container_app" "main" {
  name                         = var.container_app_name
  resource_group_name          = data.azurerm_resource_group.main.name
  container_app_environment_id = azurerm_container_app_environment.main.id
  revision_mode = "Single"

  # Ingress-Konfiguration
  ingress {
    external_enabled = true
    target_port      = var.container_port
    transport        = "auto"
    traffic_weight {
      percentage = 100
      revision_suffix = "initial"
    }
  }

  template {
    container {
      name   = var.container_app_name
      image  = var.container_image
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }
}
