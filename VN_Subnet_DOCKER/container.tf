# resource "azurerm_container_app_environment" "env" {
#   depends_on = [ data.azurerm_resource_group.main ]
#   name                       = "env-containerapp"
#   location                   = data.azurerm_resource_group.main.location
#   resource_group_name        = data.azurerm_resource_group.main.name
#   internal_load_balancer_enabled = true
#   infrastructure_subnet_id = azurerm_subnet.private_container_subnet.id
  
# }

# resource "azurerm_container_app" "app" {
#   depends_on = [ data.azurerm_resource_group.main, null_resource.acr_push ]
#   name                         = "my-containerapp"
#   container_app_environment_id = azurerm_container_app_environment.env.id
#   resource_group_name          = data.azurerm_resource_group.main.name
#   revision_mode                = "Single"
#   template {
#     container {
#       name = "myapp"
#       image = "gamedevsconnect.azurecr.io/nginx:latest"
#       cpu = "0.5"
#       memory = "1.0Gi"
#     }
#   }

#   ingress {
#     external_enabled = true
#     target_port = 80
#     traffic_weight {
#       percentage = 20
#       latest_revision = true
#     }
#   }

#   }

