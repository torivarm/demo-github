provider "azurerm" {
  features {}
}

resource "random_string" "random_string" {
  length  = 8
  special = false
  upper   = false
}

# Create Resource Group
resource "azurerm_resource_group" "rg_web" {
  name     = var.resource_group_name
  location = var.location
}

# Create Storage Account
resource "azurerm_storage_account" "sa_web" {
  name                     = "staticweb${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg_web.name
  location                 = azurerm_resource_group.rg_web.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  StaticWebsite {
    index_document = "index.html"
  }
}

# Add a index.html file to the storage account
resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.sa_web.name
  storage_container_name = azurerm_storage_container.sc_web.name
  type                   = "Block"
  content_type = "text/html"
  source                 = "<h1>Static web page deployed using Terraform</h1>"
}


resource "azurerm_storage_container" "sc_web" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.sa_web.name
  container_access_type = "private"
}

