resource "azurerm_user_assigned_identity" "this_managedidentity" {
  location            = azurerm_resource_group.this_rg.location
  name                = var.managedid
  resource_group_name = azurerm_resource_group.this_rg.name
}

resource "azurerm_role_assignment" "this_kv_role" {
  scope                = azurerm_resource_group.this_rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this_managedidentity.principal_id
}
