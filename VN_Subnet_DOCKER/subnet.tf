# resource "azurerm_subnet" "private_container_subnet" {
#   name                 = "snet-containerapp-private"
#   resource_group_name  = data.azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = [local.private_container_address_space]
  
#   # delegation {
#   #   name = "delegation"
#   #   service_delegation {
#   #     name = "Microsoft.App/environments"
#   #     actions = [
#   #       "Microsoft.Network/virtualNetworks/subnets/action"
#   #     ]
#   #   }
#   # }
# }