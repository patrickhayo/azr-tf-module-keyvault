resource "azurerm_resource_group" "this" {
  name     = uuid()
  location = "westeurope"
}

data "azurerm_client_config" "current" {}

module "key_vault" {
  source              = "./module"
  name                = "MyKeyVaultName"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}
