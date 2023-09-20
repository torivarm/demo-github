terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
    backend "azurerm" {
    resource_group_name  = "rg-backend-tfstate-dev"
    storage_account_name = "sabetfss61r3a4sy5"
    container_name       = "tfstate"
    key                  = "webapp-backend.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}