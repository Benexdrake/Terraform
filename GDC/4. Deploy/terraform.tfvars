private_key_path    = "../.ssh/vm"

subnets = {
    "public"="snet-public",
    "private"="snet-private",
    "sql"="snet-sql-private"
}

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
  "dashboard" = {
    name = "dashboard",
    interface = "public_dashboard",
    image = {
      link = "benexdrake012/gamedevsconnect_frontend:latest",
      port = {
        from = "80"
        to = "3000"
      },
    }
    admin_username = "ubuntu",
    admin_ssh = {
      username = "ubuntu"
    }
  },
  "gateway" = {
    name = "gateway",
    interface = "public_gateway",
    image = {
      link = "-e ASPNETCORE_ENVIRONMENT=Development benexdrake012/gamedevsconnect_backend_api_gateway:latest",
      port = {
        from = "80"
        to = "8080"
      }
    },
    admin_username = "ubuntu",
    admin_ssh = {
      username = "ubuntu"
    }
  },
    "apitag" = {
    name = "apitag",
    interface = "private",
    image = {
      link = "benexdrake012/gamedevsconnect_backend_api_tag:latest",
      port = {
        from = "80"
        to = "8080"
      }
    },
    admin_username = "ubuntu",
    admin_ssh = {
      username = "ubuntu"
    }
  }
}