// use terraform init -reconfigure -backend-config=secrets.tfvars for variables in backend

// terraform plan -var-file="secrets.tfvars"
// terraform apply -var-file="secrets.tfvars"
// terraform apply -var-file "./secrets.tfvars" -var-file "./env/dev.tfvars"
resource "random_string" "keyvault_suffix" {
  length = 6
  upper = false
  special = false
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "main" {
  name                        = "kv-${var.application_name}-${var.environment_name}-${random_string.keyvault_suffix.result}"
  location                    = var.primary_location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
}

// No Permission
# resource "azurerm_role_assignment" "terraform_user" {
#   scope                 = azurerm_key_vault.main.id
#   role_definition_name  = "Key Vault Administrator"
#   principal_id          = data.azurerm_client_config.current.object_id
# }