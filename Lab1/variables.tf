// Input Variables
variable "application_name" {
    type = string
    
    validation {
        condition = length(var.application_name) <= 15
        error_message = "Application Name must be less than or equal to 15 Characters."
    }
}

variable "environment_name" {
    type = string
}

variable "api_key" {
    sensitive = true
    type = string
}

variable "instance_count" {
    type = number
    validation {
      condition = var.instance_count >= local.min_nodes && var.instance_count <= local.max_nodes && var.instance_count % 2 != 0
      error_message = "Must be between ${local.min_nodes} and ${local.max_nodes} and never even!"
    }
}

variable "enabled" {
    type = bool
}

variable "regions" {
    type = list(string)
}

variable "region_instance_count" {
    type = map(string)
}

variable "region_set" {
    type = set(string)
}

variable "sku_settings" {
    type = object({
        kind = string
        tier = string
    })
}