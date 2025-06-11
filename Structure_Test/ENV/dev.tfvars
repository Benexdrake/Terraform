application_name    = "gamedevsconnect"
environment_name    = "dev"
base_address_space  = "10.0.0.0/16"
private_key_path    = "../.ssh/vm"

vm_config = {
    size = "Standard_A1_v2"
    os_disk = {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
}

vms = {
  "alpha" = {
    name = "alpha"
    interface = "public"
    image = {
      name = "nginx"
      version = "latest"
      port = {
        from = "80"
        to = "80"
      }
    }
    admin_username = "ubuntu"
    admin_ssh = {
      username = "ubuntu"
    }
  },
  "beta" = {
    name = "beta"
    interface = "private"
    image = {
      name = "nginx"
      version = "latest"
      port = {
        from = "80"
        to = "80"
      }
    }
    admin_username = "ubuntu"
    admin_ssh = {
      username = "ubuntu"
    }
  }
}