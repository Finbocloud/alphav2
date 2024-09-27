locals {
  owner       = var.owner
  environment = var.environment
  tags = {
    environment = local.environment
    owner     = local.owner
  }
}