terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}
provider "azurerm" {
    subscription_id = var.subscriprion_id
  features {}
}