output "resource_group_name" {
  value = var.resource_group_name
}

output "storage_account_name" {
  value = var.storage_account_name
}

output "container_name" {
  value = var.container_name
}

output "vm1-ip" {
  value = azurerm_public_ip.vm1.ip_address
}