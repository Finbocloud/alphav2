data "azurerm_client_config" "current" {}

module "alphav2-resources" {
    source = "../../modules"
    rg = var.rg
    location = var.location
  
}