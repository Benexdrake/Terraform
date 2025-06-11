variable "application_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "vnet_name" {
  description = "Der Name des virtuellen Netzwerks."
  type        = string
  default     = "vnet-containerapp"
}

variable "vnet_address_space" {
  description = "Der Adressbereich des virtuellen Netzwerks."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Der Name des Subnetzes für die Container App."
  type        = string
  default     = "snet-containerapp"
}

variable "container_app_env_name" {
  description = "Der Name der Container App Environment."
  type        = string
  default     = "cae-myexample"
}

variable "container_app_name" {
  description = "Der Name der Container App."
  type        = string
  default     = "hello-world-app"
}

variable "container_image" {
  description = "Das Docker-Image für die Container App."
  type        = string
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "container_port" {
  description = "Der Port, auf dem der Container lauscht."
  type        = number
  default     = 80
}