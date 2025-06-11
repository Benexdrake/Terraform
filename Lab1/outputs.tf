// To use first plan and apply
// terraform output application_name

output "application_name" {
  value = var.application_name
}

output "environment_name" {
  value = var.environment_name
}

output "environment_prefix" {
  value = local.environment_prefix
}

output "suffix" {
  value = random_string.suffix.result
}

// Sensitive / Secret will show <sensitive> but can be seen by terraform output api_key
# output "api_key" {
#   value = var.api_key
#   sensitive = true
# }

# output "enabled" {
#   value = var.enabled
# }

# output "primary_region" {
#   value = var.regions[0]
# }

# output "primary_region_instance" {
#   value = var.region_instance_count[var.regions[0]]
# }

# output "region_set" {
#   value = ""
# }

# output "kind" {
#   value = var.sku_settings.kind
# }

# output "tier" {
#   value = var.sku_settings.tier
# }

# output "charlie" {
#   value = module.charlie.random_string
# }

# output "regionA" {
#   value = module.regional_stamps[0].name
# }

# output "regionB" {
#   value = module.regional_stamps[1].name
# }

output "regionA" {
  value = module.regional_stamps["foo"].region
}

output "regionB" {
  value = module.regional_stamps["bar"].region
}