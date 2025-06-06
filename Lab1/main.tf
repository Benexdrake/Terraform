// terraform plan / apply / destroy

resource "random_string" "suffix" {
  length = 12
  upper = false
  special = false
}

locals {
  environment_prefix = "${var.application_name}-${var.environment_name}-${random_string.suffix.result}"
}

# resource "random_string" "list" {
#   count = length(var.regions)
  
#   length = 12
#   upper = false
#   special = false
# }

# resource "random_string" "map" {
#   for_each = var.region_instance_count
  
#   length = 12
#   upper = false
#   special = false
# }

# resource "random_string" "if" {
#   count = var.enabled ? 1 : 0

#   length = 12
#   upper = false
#   special = false
# }

# module "module" {
#   source = "hashicorp/module/random"
#   version = "1.0.0"
# }

# module "charlie" {
#   source = "./modules/rando"

#   length = 8
# }

# module "regionA" {
#   source = "./modules/rando/regional-stamp"
#   region = "westus"
#   name = "foo"
#   min_node_count = 4
#   max_node_count = 8
# }

locals {
  # regional_stamps = [
  #   {
  #     region = "westus"
  #     name = "foo"
  #     min_node_count = 4
  #     max_node_count = 8
  #   },
  #       {
  #     region = "eastus"
  #     name = "bar"
  #     min_node_count = 2
  #     max_node_count = 4
  #   }
  # ]

    regional_stamps = {
    "foo" = {
      region = "westus"
      min_node_count = 4
      max_node_count = 8
    },
    "bar" = {
      region = "eastus"
      min_node_count = 2
      max_node_count = 4
    }
    }
}

# module "regional_stamps" {
#   source = "./modules/rando/regional-stamp"

#   count = length(local.regional_stamps)

#   region = local.regional_stamps[count.index].region
#   name = local.regional_stamps[count.index].name
#   min_node_count = local.regional_stamps[count.index].min_node_count
#   max_node_count = local.regional_stamps[count.index].max_node_count
# }


module "regional_stamps" {
  source = "./modules/rando/regional-stamp"

  for_each = local.regional_stamps

  region = each.value.region
  name = each.key
  min_node_count = each.value.min_node_count
  max_node_count = each.value.max_node_count
}

// known after apply if variables are not loaded
// terraform console -var-file ./env/dev.tfvars > local.environment_prefix