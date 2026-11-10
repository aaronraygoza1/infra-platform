terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate15300" #Cambiar nombre
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}