
#Read the configuration details at the foot of this manifest
resource "azurerm_kubernetes_cluster" "this_aks" {
  name                = var.aks
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  dns_prefix          = "${var.environment}-cluster"
  kubernetes_version  = "1.31"
  #kubernetes_version  = data.azurerm_kubernetes_service_versions.current.version_prefix
  node_resource_group = "${azurerm_resource_group.this_rg.name}-network-rg"
  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = "1.31" #data.azurerm_kubernetes_service_versions.current.version_prefix
    zones                = [1, 2, 3]
    auto_scaling_enabled  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    vnet_subnet_id       = azurerm_subnet.this_subnet.id
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
    tags = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
  }
  # Identity (System Assigned or Service Principal)
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this_user_id.id]
  }
  azure_policy_enabled = true
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
    dns_service_ip    = "10.3.0.10"
    service_cidr      = "10.3.0.0/16"
  }

  #create tag in local.tf and update reference
  tags = {
    Environment = "dev"
  }
}
