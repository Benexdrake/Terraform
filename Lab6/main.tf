// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

// use terraform init -reconfigure -backend-config=secrets.tfvars for variables in backend

// terraform apply -var-file "./secrets.tfvars" -var-file "./env/dev.tfvars" -auto-approve

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

// get My IP
# data "http" "my_ip" {
#   url = "https://ifconfig.me/ip"
# }

// Create an SSH Key
resource "tls_private_key" "vm1" {
  algorithm = "RSA"
  rsa_bits = 4096
}

// Create a VM
# resource "azurerm_linux_virtual_machine" "vm1" {
#   name                = "vm1${var.application_name}${var.environment_name}"
#   resource_group_name = data.azurerm_resource_group.main.name
#   location            = data.azurerm_resource_group.main.location
#   size                = "Standard_A1_v2"
#   admin_username      = "adminuser"
#   network_interface_ids = [
#     azurerm_network_interface.vm1.id,
#   ]
  

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = tls_private_key.vm1.public_key_openssh
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
#   // Dont work
#   # custom_data = filebase64("./customdata.tpl")
# }

# resource "local_file" "private_key" {
#   content = tls_private_key.vm1.private_key_pem
#   filename = pathexpand("./.ssh/vm1")
#   file_permission = "0600"
# }

# resource "local_file" "public_key" {
#   content = tls_private_key.vm1.public_key_openssh
#   filename = pathexpand("./.ssh/vm1.pub")
# }

data "azurerm_client_config" "current" {}

# resource "azurerm_key_vault_access_policy" "terraform" {
#   key_vault_id = azurerm_key_vault.main.id

#   tenant_id = data.azurerm_client_config.current.tenant_id
#   object_id = data.azurerm_client_config.current.object_id

#   secret_permissions = [
#     "Get",
#     "Set",
#     "List",
#     "Delete"
#   ]
# }

resource "random_string" "keyvault_suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_key_vault" "main" {
  name                        = "kv-${var.application_name}-${var.environment_name}-${random_string.keyvault_suffix.result}"
  location                    = data.azurerm_resource_group.main.location
  resource_group_name         = data.azurerm_resource_group.main.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  # enable_rbac_authorization   = true // No Permission
}

// Dont work because of rbac no permission
# resource "azurerm_key_vault_secret" "vm1_ssh_private" {
#   name            = "vm1-ssh-private"
#   value           = tls_private_key.vm1.private_key_pem
#   key_vault_id    = azurerm_key_vault.main.id
# }

# resource "azurerm_key_vault_secret" "vm1_ssh_public" {
#   name            = "vm1-ssh-public"
#   value           = tls_private_key.vm1.public_key_openssh
#   key_vault_id    = azurerm_key_vault.main.id
# }