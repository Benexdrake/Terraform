locals {
  public_address_space            = cidrsubnet(var.base_address_space, 3, 0)
  public_container_address_space  = cidrsubnet(var.base_address_space, 3, 1)
  private_address_space           = cidrsubnet(var.base_address_space, 3, 2)
  private_container_address_space = cidrsubnet(var.base_address_space, 3, 3)
  sql_private_space               = cidrsubnet(var.base_address_space, 3, 4)
}
