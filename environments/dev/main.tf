module "vnet" {
  source        = "../../modules/vnet"
  name          = "vnet-dev"
  address_space = ["10.20.0.0/16"]
  location      = "eastus2"
}