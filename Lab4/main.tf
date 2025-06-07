// use terraform init -reconfigure -backend-config=secrets.tfvars for variables in backend

// terraform plan -var-file="secrets.tfvars"
// terraform apply -var-file="secrets.tfvars"
// terraform apply -var-file "./secrets.tfvars" -var-file "./env/dev.tfvars"

resource "random_string" "keyvault_suffix" {
  length  = 6
  upper   = false
  special = false
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "main" {
  name                        = "kv-${var.application_name}-${var.environment_name}-${random_string.keyvault_suffix.result}"
  location                    = var.primary_location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  # enable_rbac_authorization   = true // No Permission
}

// No Permission
# resource "azurerm_role_assignment" "terraform_user" {
#   scope                 = azurerm_key_vault.main.id
#   role_definition_name  = "Key Vault Administrator"
#   principal_id          = data.azurerm_client_config.current.object_id
# }

resource "azurerm_log_analytics_workspace" "main" {
  name                = "log-${var.application_name}-${var.environment_name}"
  location            = var.primary_location
  resource_group_name = var.resource_group_name
  sku = "PerGB2018"
  retention_in_days   = 30
}

// If someone other has a log analytics workspace or with an other Terraform state like Lab3
# data "azurerm_log_analytics_workspace" "observability" {
#   name = ""
#   resource_group_name = ""
# }

resource "azurerm_monitor_diagnostic_setting" "main" {
  name                        = "diag-${var.application_name}-${var.environment_name}-${random_string.keyvault_suffix.result}"
  target_resource_id          = azurerm_key_vault.main.id

  log_analytics_workspace_id  = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category_group = "audit"
  }

  enabled_log {
    category_group = "allLogs"
  }

  # enabled_metric {
  #   category = "AllMetrics"
  # }
}