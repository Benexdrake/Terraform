terraform {
  required_providers {
    azurerm = {
      source    = "hashicorp/azurerm"
      version   = "~> 4.32.0"
    }
    random = {
        source  = "hashicorp/random"
        version = "~> 3.7.2"
    }
  }
}