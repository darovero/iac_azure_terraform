output "resource_group_names" {
  value = {
    for key, rg in module.resource_groups : key => rg.resource_group_name
  }
}

output "resource_group_ids" {
  value = {
    for key, rg in module.resource_groups : key => rg.resource_group_id
  }
}

output "log_analytics_names" {
  value = {
    for key, law in module.log_analytics_workspaces : key => law.log_analytics_name
  }
}

output "log_analytics_ids" {
  value = {
    for key, law in module.log_analytics_workspaces : key => law.log_analytics_id
  }
}

output "log_analytics_workspace_ids" {
  value = {
    for key, law in module.log_analytics_workspaces : key => law.log_analytics_workspace_id
  }
}

output "key_vault_names" {
  value = {
    for key, kv in module.key_vaults : key => kv.key_vault_name
  }
}

output "key_vault_ids" {
  value = {
    for key, kv in module.key_vaults : key => kv.key_vault_id
  }
}

output "key_vault_uris" {
  value = {
    for key, kv in module.key_vaults : key => kv.key_vault_uri
  }
}

output "storage_account_names" {
  value = {
    for key, st in module.storage_accounts : key => st.storage_account_name
  }
}

output "storage_account_ids" {
  value = {
    for key, st in module.storage_accounts : key => st.storage_account_id
  }
}

output "storage_account_blob_endpoints" {
  value = {
    for key, st in module.storage_accounts : key => st.primary_blob_endpoint
  }
}

output "sql_server_names" {
  value = {
    for key, sql in module.sql_servers : key => sql.sql_server_name
  }
}

output "sql_server_ids" {
  value = {
    for key, sql in module.sql_servers : key => sql.sql_server_id
  }
}

output "sql_server_fqdns" {
  value = {
    for key, sql in module.sql_servers : key => sql.sql_server_fqdn
  }
}