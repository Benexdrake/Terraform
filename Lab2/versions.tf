terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.32.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.7.2"
    }
  }
}

// az account show - shows all data as json, like the subscription id
// subscription id as system variable: $env:ARM_SUBSCRIPTION_ID = "id" < Powershell
// export ARM_SUBSCRIPTION_ID="id" < Bash
provider "azurerm" {
  features {}
  subscription_id = "subscription_id_insert_here" // or use a exported variable with Powershell or Bash
}