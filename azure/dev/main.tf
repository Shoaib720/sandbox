resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = "Central India"
}