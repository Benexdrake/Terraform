locals {
  network_interface_ids = {
    "public" = {
        ids = [data.azurerm_network_interface.public.id]
    },
    "private" = {
        ids = [data.azurerm_network_interface.private.id]
    }
  }
}
