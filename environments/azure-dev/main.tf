module "vnet" {
  source        = "../../modules/vnet"
  name          = "vnet-dev"
  address_space = ["10.20.0.0/16"]
  location      = "eastus2"
}

module "aks" {
  source     = "../../modules/aks"
  name       = "aks-dev"
  location   = "eastus2"
  node_count = 1
  vm_size    = "Standard_D2als_v6"
}
