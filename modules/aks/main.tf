resource "azurerm_resource_group" "this" {
  name     = "rg-${var.name}"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = var.name
  sku_tier            = "Free"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    ambiente = "dev"
    dueno    = "aaron"
  }
}