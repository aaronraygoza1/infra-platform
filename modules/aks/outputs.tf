module "aks" {
  source     = "../../modules/aks"
  name       = "aks-dev"
  location   = "eastus2"
  node_count = 1
  vm_size    = "Standard_B2s"
}