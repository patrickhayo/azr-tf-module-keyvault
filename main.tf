terraform {
  required_version = ">=0.14.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.36.0"
    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}

resource "azurerm_key_vault" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = var.sku_name
  tags                            = var.tags
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days

  timeouts {
    delete = "60m"
  }

  network_acls {
    bypass                     = var.bypass
    default_action             = var.default_action
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
