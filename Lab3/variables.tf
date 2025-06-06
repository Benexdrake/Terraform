variable "resource_group_name" {
  type = string
}

variable "primary_location" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "container_name" {
  
}

variable "key" {
  sensitive = true
  type = string
}