terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.21.1"
    }
  }
  backend "azurerm" {
    resource_group_name   = "basic-rg"
    storage_account_name  = "stgaccterraformfiles"
    container_name        = "tfstates"
    key                   = "sandbox.dev.terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  
}