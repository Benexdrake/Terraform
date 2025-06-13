variable "application_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_login_password" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
      source = "terraform",
      plattform = "gdc",
      part = "sql"
    }
}