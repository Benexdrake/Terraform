# resource "azurerm_network_interface" "private_container" {
#   name                = "nic-${var.application_name}-${var.environment_name}-private-container"
#   location            = data.azurerm_resource_group.main.location
#   resource_group_name = data.azurerm_resource_group.main.name

#   ip_configuration {
#     name                          = "privat"
#     subnet_id                     = azurerm_subnet.private_container_subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }   
# }