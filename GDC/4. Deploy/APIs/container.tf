# resource "azurerm_container_app" "tag" {
#   name                         = "api-tag-container" //
#   resource_group_name          = data.azurerm_resource_group.main.name
#   container_app_environment_id = data.azurerm_container_app_environment.private.id //
#   revision_mode = "Single"

#   ingress {
#     external_enabled = true //
#     target_port      = 8080 //
#     transport        = "auto"
#     traffic_weight {
#       percentage = 100
#       revision_suffix = "initial"
#     }
#   }

#   template {
#     container { //
#       name   = "appname" //
#       image  = "benexdrake012/gamedevsconnect_backend_api_tag" //
#       cpu    = 0.5 //
#       memory = "1.0Gi" //
#     }
#   }
# }



resource "azurerm_container_app" "tag" {
  name                         = "api-tag-container"
  resource_group_name          = data.azurerm_resource_group.main.name
  container_app_environment_id = data.azurerm_container_app_environment.private.id
  revision_mode = "Single"

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
      name   = "tag"
      image  = "benexdrake012/gamedevsconnect_backend_api_tag"
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }

  tags = var.tags
}

resource "azurerm_container_app" "gateway" {
  depends_on = [ azurerm_container_app.tag ]
  name                         = "api-gateway-container"
  resource_group_name          = data.azurerm_resource_group.main.name
  container_app_environment_id = data.azurerm_container_app_environment.public.id
  revision_mode = "Single"

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
      name   = "gateway"
      image  = "benexdrake012/gamedevsconnect_backend_api_gateway"
      cpu    = 0.5
      memory = "1.0Gi"
      env {
       name = "TAG_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "AZURE_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "FILE_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "NOTIFICATION_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "PROJECT_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "PROFILE_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "REQUEST_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "TAG_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
      env {
       name = "USER_URL" 
       value = "https://${azurerm_container_app.tag.latest_revision_fqdn}"
      }
    }
  }
  tags = var.tags
}