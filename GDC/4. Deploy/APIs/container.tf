resource "azurerm_container_app" "gateway" {
  name                         = "api-gateway-container"
  resource_group_name          = data.azurerm_resource_group.main.name
  container_app_environment_id = data.azurerm_container_app_environment.public.id
  revision_mode = "Single"

  # Ingress-Konfiguration
  ingress {
    external_enabled = true
    target_port      = 8080
    transport        = "auto"
    traffic_weight {
      percentage = 100
      revision_suffix = "initial"
    }
  }

  template {
    container {
      name   = "appname"
      image  = "benexdrake012/gamedevsconnect_backend_api_gateway"
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }
}

resource "azurerm_container_app" "tag" {
  name                         = "api-tag-container"
  resource_group_name          = data.azurerm_resource_group.main.name
  container_app_environment_id = data.azurerm_container_app_environment.public.id
  revision_mode = "Single"

  # Ingress-Konfiguration
  ingress {
    external_enabled = true
    target_port      = 8080
    transport        = "auto"
    traffic_weight {
      percentage = 100
      revision_suffix = "initial"
    }
  }

  template {
    container {
      name   = "appname"
      image  = "benexdrake012/gamedevsconnect_backend_api_tag"
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }
}