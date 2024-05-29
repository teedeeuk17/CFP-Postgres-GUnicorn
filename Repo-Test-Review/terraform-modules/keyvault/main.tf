
resource "azurerm_key_vault" "az_keyvault" {
  name                            = var.az_kv_name
  location                        = var.az_region
  resource_group_name             = var.az_resource_group_name
  sku_name                        = var.sku_name
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  soft_delete_retention_days      = "7"
  purge_protection_enabled        = true
  tenant_id                       = var.az_tenant_id
  enable_rbac_authorization       = true
  public_network_access_enabled   = false

  network_acls {
  default_action                  = "Deny"
  bypass                          = "AzureServices"
  virtual_network_subnet_ids      = [] #[]
  #ip_rules                        = [] # changed to managment box when deployed
  
}

access_policy {
    tenant_id = var.az_tenant_id
    object_id = var.az_object_id
key_permissions = [
      "Create",
      "Get",
      "Purge",
      "List",
      "Recover",
      "Delete",
      "WrapKey",
      "UnwrapKey",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]
    certificate_permissions = [
    "Get", "List"
    ]
    secret_permissions = [
      "Get", "Backup", "List", "Set","Delete", "Purge","Recover"
    ]
    storage_permissions = [
      "Get",
    ]
  }
}



resource "azurerm_key_vault_access_policy" "kvmain_ap1" {
  key_vault_id = azurerm_key_vault.az_keyvault.id

  tenant_id = var.tenant_id
  object_id = var.object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kvmain_ap2" {
  key_vault_id = azurerm_key_vault.az_keyvault.id

  tenant_id = var.tenant_id
  object_id = var.object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kvmain_ap3" {
  key_vault_id = azurerm_key_vault.az_keyvault.id

  tenant_id = var.tenant_id
  object_id = var.object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}

resource "azurerm_key_vault_access_policy" "kvmain_ap4" {
  key_vault_id = azurerm_key_vault.az_keyvault.id

  tenant_id = var.tenant_id
  object_id = var.object_id

  key_permissions = [
    "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey",
  ]

  secret_permissions = [
    "backup", "delete", "get", "list", "purge", "recover", "restore", "set",
  ]
}