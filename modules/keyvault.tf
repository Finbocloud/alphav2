data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "this_keyvault" {
  name                       = "${local.owner}-${var.keyvault}-${local.environment}"
  location                   = azurerm_resource_group.this_rg.location
  resource_group_name        = azurerm_resource_group.this_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  network_acls {                            
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = [ "37.60.108.149", ] 
    virtual_network_subnet_ids = []
  }
}

resource "azurerm_key_vault_access_policy" "this_user_assigned_identity" {
  key_vault_id = azurerm_key_vault.this_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.this_manageidentity.principal_id

  secret_permissions = [

    "Get"

  ]
}
resource "azurerm_key_vault_access_policy" "this_eka_access_policy" {
  key_vault_id = azurerm_key_vault.this_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "f7cff743-2566-4b6c-96aa-c79114a822cf"

  secret_permissions = [
    "Set",
    "Get",
    "Delete",
    "List"
  ]
}