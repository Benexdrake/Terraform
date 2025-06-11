locals {
  public_address_space   = cidrsubnet(var.base_address_space, 2, 0) //26
  private1_address_space   = cidrsubnet(var.base_address_space, 2, 1) //26
  private2_address_space   = cidrsubnet(var.base_address_space, 2, 2) //26

  network_interface_ids = {
    "alpha" = {
        network_interface_id = azurerm_network_interface.public.id
    },
    "beta" = {
        network_interface_id = azurerm_network_interface.private1.id
    },
    "delta" = {
        network_interface_id = azurerm_network_interface.private2.id
    }
  }
}
