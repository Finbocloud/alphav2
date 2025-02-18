provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_linux_virtual_machine" "my_linux_vm" {
  location = "eastus"
  name = "test"
  resource_group_name = "test"
  admin_username = "testuser"
  admin_password = "Testpa5s"

  size = "Standard_F16s" # <<<<<<<<<< Try changing this to Standard_F16s_v2 to compare the costs

  tags = {
    Environment = "production"
    Service = "web-app"
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface_ids = [
    "/subscriptions/123/resourceGroups/testrg/providers/Microsoft.Network/networkInterfaces/testnic",
  ]

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "16.04-LTS"
    version = "latest"
  }
}

