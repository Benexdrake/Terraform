data "azurerm_mssql_server" "main" {
    name                = "${var.application_name}-sqlserver"
    resource_group_name = data.azurerm_resource_group.main.name
}

// Private Subnet Access
resource "azurerm_private_endpoint" "sql_private_endpoint" {
  depends_on = [ azurerm_subnet.private_sql_subnet ]
  name                = "${var.application_name}-sql-pe"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.private_sql_subnet.id

  private_service_connection {
    name                           = "${var.application_name}-sql-psc"
    private_connection_resource_id = data.azurerm_mssql_server.main.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }
}
