// Creates a Network Interface card for VMs
resource "azurerm_network_interface" "public" {
  name                = "nic-${var.application_name}-${var.environment_name}-public-dashboard"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public_dashboard"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_dashboard.id
  }   
}

resource "azurerm_network_interface" "public_gateway" {
  name                = "nic-${var.application_name}-${var.environment_name}-public-gateway"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public_dashboard"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_gateway.id
  }   
}

resource "azurerm_network_interface" "private" {
  name                = "nic-${var.application_name}-${var.environment_name}-private"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "privat"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
  }   
}