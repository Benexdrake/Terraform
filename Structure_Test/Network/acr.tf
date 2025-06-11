data "azurerm_container_registry" "main" {
  name = "${var.application_name}"
  resource_group_name = var.resource_group_name
}

resource "null_resource" "acr_push" {
    for_each = var.vms
    depends_on = [ data. azurerm_container_registry.main ]
  provisioner "local-exec" {
    command = "bash ./docker/acr.sh ${each.value.image.name}"
  }
}