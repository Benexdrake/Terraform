resource "azurerm_subnet" "public" {
  name                  = "subnet-public"
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [local.public_address_space]
}

resource "azurerm_subnet" "private" {
  name                 = "subnet-private"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.private_address_space]
}

// Container Subnets
resource "azurerm_subnet" "public_container" {
  name                  = "subnet-public-container"
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [local.public_container_address_space]

    delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_subnet" "private_container" {
  name                 = "subnet-private-container"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.private_container_address_space]

    delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

// SQL Server Private Subnet
resource "azurerm_subnet" "private_sql_subnet" {
  name                 = "subnet-private-sql"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.sql_private_space]
  private_endpoint_network_policies = "Enabled"
}