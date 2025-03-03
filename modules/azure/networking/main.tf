resource "azurerm_virtual_network" "vnet01" {
  name                = "${var.project}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "private_subnet_01" {
  name                 = "${var.project}-private01"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.0.2.0/24"]   # please change according to harbinger client subnet
}