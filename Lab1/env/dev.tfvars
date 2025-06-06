// to use this file: terraform apply -var-file ./env/dev.tfvars 

environment_name = "dev"
instance_count = 7
enabled = true
regions = ["west", "east"]
region_instance_count = {
    "west" = 4
    "east" = 8
}
region_set = ["westus", "eastus"]
sku_settings = {
    kind = "P"
    tier = "Business"
}