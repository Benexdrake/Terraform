locals {
# alpha_address_space   = cidrsubnet(var.base_address_space, 2, 0)
  bastion_address_space = cidrsubnet(var.base_address_space, 4, 0) //26
  bravo_address_space   = cidrsubnet(var.base_address_space, 2, 1) //24
  charlie_address_space = cidrsubnet(var.base_address_space, 2, 2) //24
  delta_address_space   = cidrsubnet(var.base_address_space, 2, 3) //24
}

// Creates a VN
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.application_name}-${var.environment_name}"
  location            = var.primary_location
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = [var.base_address_space]
}

// 10.40.0.0/26
// Creates a Bastion Subnet
resource "azurerm_subnet" "bastion" {
  name                  = "AzureBastionSubnet"
  resource_group_name   = data.azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [local.bastion_address_space]
}

// Creates a Subnet named alpha 10.40.0.0/24
# resource "azurerm_subnet" "alpha" {
#   name                  = "snet-alpha"
#   resource_group_name   = data.azurerm_resource_group.main.name
#   virtual_network_name  = azurerm_virtual_network.main.name
#   address_prefixes      = [local.alpha_address_space]
# }

// Creates a Subnet named bravo 10.40.1.0/24
# resource "azurerm_subnet" "bravo" {
#   name                  = "snet-bravo"
#   resource_group_name   = data.azurerm_resource_group.main.name
#   virtual_network_name  = azurerm_virtual_network.main.name
#   address_prefixes      = [local.bravo_address_space]
# }

# // Creates a Subnet named charlie 10.40.2.0/24
# resource "azurerm_subnet" "charlie" {
#   name                  = "snet-charlie"
#   resource_group_name   = data.azurerm_resource_group.main.name
#   virtual_network_name  = azurerm_virtual_network.main.name
#   address_prefixes      = [local.charlie_address_space]
# }

# // Creates a Subnet named delta 10.40.3.0/24
# resource "azurerm_subnet" "delta" {
#   name                  = "snet-delta"
#   resource_group_name   = data.azurerm_resource_group.main.name
#   virtual_network_name  = azurerm_virtual_network.main.name
#   address_prefixes      = [local.delta_address_space]
# }

// Creates a nsg for remote access (ssh/22)
# resource "azurerm_network_security_group" "remote_access" {
#   name                = "ngs-${var.application_name}-${var.environment_name}-remote-access"
#   location            = var.primary_location
#   resource_group_name = data.azurerm_resource_group.main.name

#   security_rule {
#     name                        = "remote"
#     priority                    = 100
#     direction                   = "Inbound"
#     access                      = "Allow"
#     protocol                    = "Tcp"
#     source_port_range           = "*"
#     destination_port_ranges     = ["22", "80"]
#     source_address_prefix       = chomp(data.http.my_ip.response_body)
#     destination_address_prefix  = "*"
#   }
# }

// Connecting Subnet alpha with NSG
# resource "azurerm_subnet_network_security_group_association" "alpha_remote_access" {
#   subnet_id                 = azurerm_subnet.alpha.id
#   network_security_group_id = azurerm_network_security_group.remote_access.id
# }

// Creates a Public static IP
resource "azurerm_public_ip" "vm1" {
  name                = "pip-${var.application_name}-${var.environment_name}-vm1"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"
}

// Creates a Network Interface card for VMs
# resource "azurerm_network_interface" "vm1" {
#   name                = "nic-${var.application_name}-${var.environment_name}-vm1"
#   location            = data.azurerm_resource_group.main.location
#   resource_group_name = data.azurerm_resource_group.main.name

#   ip_configuration {
#     name                          = "public"
#     subnet_id                     = azurerm_subnet.alpha.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.vm1.id
#   }   
# }

// Create Public IP for Bastion Host
resource "azurerm_public_ip" "bastion" {
  name                = "pip-${var.application_name}-${var.environment_name}-bastion"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

// Create Bastion Host
resource "azurerm_bastion_host" "bastion" {
    name                = "bas-${var.application_name}-${var.environment_name}"
    location            = data.azurerm_resource_group.main.location
    resource_group_name = data.azurerm_resource_group.main.name

    ip_configuration {
      name                  = "configuration"
      subnet_id             = azurerm_subnet.bastion.id
      public_ip_address_id  = azurerm_public_ip.bastion.id
    }
  
}