locals {
  owner       = var.owner
  environment = var.environment
  tags = {
    environment = "dev"
    project     = "alphav2"
  }
}