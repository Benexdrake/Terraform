output "resource_group_name" {
  description = "Der Name der Ressourcengruppe."
  value       = data.azurerm_resource_group.main.name
}

output "container_app_fqdn" {
  description = "Der vollständig qualifizierte Domänenname (FQDN) der Container App."
  value       = azurerm_container_app.main.ingress[0].fqdn
}

output "container_app_environment_id" {
  description = "Die ID der Container App Environment."
  value       = azurerm_container_app_environment.main.id
}