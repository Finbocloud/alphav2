resource "azurerm_network_security_group" "this_nsg" {
  name                = "${local.owner}-${var.nsg}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
}

resource "azurerm_network_security_rule" "this_nsg_rule" {
  name                        = "${local.owner}-${var.nsg_rule}-${local.environment}"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "azurerm_subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.this_subnet.id
  network_security_group_id = azurerm_network_security_group.this_nsg.id
}