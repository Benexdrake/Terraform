// use terraform init -reconfigure -backend-config=secrets.tfvars for variables in backend

// terraform apply -var-file "./secrets.tfvars" -var-file "./env/dev.tfvars" -auto-approve

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.application_name}-${var.environment_name}"
  location            = var.primary_location
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = [var.base_address_space]
}

locals {
  alpha_address_space   = cidrsubnet(var.base_address_space, 2, 0)
  bravo_address_space   = cidrsubnet(var.base_address_space, 2, 1)
  charlie_address_space = cidrsubnet(var.base_address_space, 2, 2)
  delta_address_space   = cidrsubnet(var.base_address_space, 2, 3)
}

resource "azurerm_subnet" "alpha" {
  name                  = "snet-alpha"
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [local.alpha_address_space]
}

resource "azurerm_subnet" "bravo" {
  name                  = "snet-bravo"
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [local.bravo_address_space]
}

resource "azurerm_subnet" "charlie" {
  name                  = "snet-charlie"
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [local.charlie_address_space]
}

resource "azurerm_subnet" "delta" {
  name                  = "snet-delta"
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [local.delta_address_space]
}

resource "azurerm_network_security_group" "remote_access" {
  name                = "ngs-${var.application_name}-${var.environment_name}-remote-access"
  location            = var.primary_location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                        = "ssh"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = chomp(data.http.my_ip.body)
    destination_address_prefix  = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "alpha_remote_access" {
  subnet_id                 = azurerm_subnet.alpha.id
  network_security_group_id = azurerm_network_security_group.remote_access.id
}

resource "azurerm_subnet_network_security_group_association" "bravo_remote_access" {
  subnet_id                 = azurerm_subnet.bravo.id
  network_security_group_id = azurerm_network_security_group.remote_access.id
}

resource "azurerm_subnet_network_security_group_association" "charlie_remote_access" {
  subnet_id                 = azurerm_subnet.charlie.id
  network_security_group_id = azurerm_network_security_group.remote_access.id
}

resource "azurerm_subnet_network_security_group_association" "delta_remote_access" {
  subnet_id                 = azurerm_subnet.delta.id
  network_security_group_id = azurerm_network_security_group.remote_access.id
}

data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}