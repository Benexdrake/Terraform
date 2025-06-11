// Create Subnet
resource "azurerm_subnet" "public" {
    name                  = "snet-public"
    resource_group_name   = data.azurerm_resource_group.main.name
    virtual_network_name  = azurerm_virtual_network.main.name
    address_prefixes      = [local.public_address_space]
}

resource "azurerm_subnet" "private" {
    name                  = "snet-private"
    resource_group_name   = data.azurerm_resource_group.main.name
    virtual_network_name  = azurerm_virtual_network.main.name
    address_prefixes      = [local.private_address_space]
}

// SQL Server Private Subnet
resource "azurerm_subnet" "private_sql_subnet" {
  name                 = "snet-sql-private"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.sql_private_space]
  private_endpoint_network_policies = "Enabled"
}