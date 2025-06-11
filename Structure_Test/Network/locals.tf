locals {
  public_address_space      = cidrsubnet(var.base_address_space, 3, 0)
  private_address_space    = cidrsubnet(var.base_address_space, 3, 1)
  private_container_address_space    = cidrsubnet(var.base_address_space, 3, 2)
  sql_private_space         = cidrsubnet(var.base_address_space, 3, 3)
}
