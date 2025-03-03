locals {
    location = "Central India"
    tags = {
        managedby = "terraform"
    }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = local.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "${var.project}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  tags     = local.tags
}

resource "azurerm_subnet" "private_subnet_01" {
  name                 = "${var.project}-private01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.0.2.0/24"]   # please change according to harbinger client subnet
  tags     = local.tags
}

module "web_server" {
  count = var.server_type == "web" ? 1 : 0
  source              = "../../modules/azure/web-server"
  project             = var.project
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.private_subnet_01.id
  tags     = local.tags
}
