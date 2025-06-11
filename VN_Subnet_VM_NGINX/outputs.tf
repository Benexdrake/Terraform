# output "alpha-ip" {
#   value = azurerm_linux_virtual_machine.alpha.public_ip_address
# }

# output "public_ips" {
#   value = {
#     alpha = "http://${azurerm_public_ip.alpha.ip_address}"
#     # beta  = "http://${azurerm_public_ip.beta.ip_address}"
#   }
# }

# output "beta" {
#   value = azurerm_linux_virtual_machine.beta.private_ip_address
# }

# output "vms_ips" {
#   value = {
#     public = "${azurerm_linux_virtual_machine.vms[*].public_ip_address}"
#     private = "${azurerm_linux_virtual_machine.vms[*].private_ip_address}"
#   }
# }

output "vm_private_ips" {
  value = {
    for vm_name, nic in azurerm_linux_virtual_machine.vms :
    vm_name => nic.private_ip_address
  }
}

output "vm_public_ips" {
  value = {
    for vm_name, nic in azurerm_linux_virtual_machine.vms :
    vm_name => "http://${nic.public_ip_address}"
  }
}