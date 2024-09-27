data "azurerm_client_config" "current" {}

module "alphav2-resources" {
    source = "../../modules"
    rg = var.rg
    location = var.location
    acr = var.acr
    aks = var.aks
    environment = var.environment
    keyvault = var.keyvault
    owner = var.owner
    tag = var.tag
}