// no need if az login and dont work
# resource "azurerm_resource_group" "main" {
#   name      = "rg-${var.application_name}-${var.environment_name}"
#   location  = var.primary_location
# }

// use terraform init -reconfigure -backend-config=secrets.tfvars for variables in backend

// terraform plan -var-file="secrets.tfvars"
// terraform apply -var-file="secrets.tfvars"
// terraform apply -var-file "./secrets.tfvars" -var-file "./env/dev.tfvars"

resource "azurerm_log_analytics_workspace" "main" {
  name = "log-${var.application_name}-${var.environment_name}"
  location = var.primary_location
  resource_group_name = var.resource_group_name
  sku = "PerGB2018"
  retention_in_days = 30
}