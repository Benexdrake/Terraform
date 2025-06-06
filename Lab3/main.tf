// no need if az login
# resource "azurerm_resource_group" "main" {
#   name      = var.resource_group_name
#   location  = var.primary_location
# }

// use terraform init -reconfigure -backend-config=secrets.tfvars for variables in backend