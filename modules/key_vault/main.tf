resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  # Configuración de políticas de acceso
  dynamic "access_policy" {
    for_each = var.object_id != null ? [var.object_id] : var.access_policy_users
    content {
      tenant_id = var.tenant_id
      object_id = access_policy.value

      secret_permissions = ["Get", "List", "Set", "Delete"]
      key_permissions    = ["Get", "List", "Create", "Delete"]
      certificate_permissions = ["Get", "List", "Create", "Delete"]
    }
  }

  tags = var.tags
}
