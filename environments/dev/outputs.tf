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

output "storage_account_primary_access_keys" {
  value = {
    for key, st in module.storage_accounts : key => st.storage_account_primary_access_key
  }
  sensitive = true
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

output "elastic_pool_names" {
  value = {
    for key, ep in module.elastic_pools : key => ep.elastic_pool_name
  }
}

output "elastic_pool_ids" {
  value = {
    for key, ep in module.elastic_pools : key => ep.elastic_pool_id
  }
}

output "virtual_network_names" {
  value = {
    for key, vnet in module.virtual_networks : key => vnet.virtual_network_name
  }
}

output "virtual_network_ids" {
  value = {
    for key, vnet in module.virtual_networks : key => vnet.virtual_network_id
  }
}

output "virtual_network_subnet_ids" {
  value = {
    for key, vnet in module.virtual_networks : key => vnet.subnet_ids
  }
}

output "container_registry_names" {
  value = {
    for key, acr in module.container_registries : key => acr.acr_name
  }
}

output "container_registry_ids" {
  value = {
    for key, acr in module.container_registries : key => acr.acr_id
  }
}

output "container_registry_login_servers" {
  value = {
    for key, acr in module.container_registries : key => acr.acr_login_server
  }
}

output "aks_names" {
  value = {
    for key, aks in module.aks_clusters : key => aks.aks_name
  }
}

output "aks_ids" {
  value = {
    for key, aks in module.aks_clusters : key => aks.aks_id
  }
}

output "aks_hosts" {
  value = {
    for key, aks in module.aks_clusters : key => aks.host
  }
  sensitive = true
}

output "aks_kubelet_identity_object_ids" {
  value = {
    for key, aks in module.aks_clusters : key => aks.kubelet_identity_object_id
  }
}

output "application_gateway_names" {
  value = {
    for key, agw in module.application_gateways : key => agw.application_gateway_name
  }
}

output "application_gateway_ids" {
  value = {
    for key, agw in module.application_gateways : key => agw.application_gateway_id
  }
}

output "application_gateway_frontend_ips" {
  value = {
    for key, agw in module.application_gateways : key => agw.application_gateway_frontend_ip
  }
}

output "virtual_machine_names" {
  value = {
    for key, vm in module.virtual_machines : key => vm.vm_name
  }
}

output "virtual_machine_ids" {
  value = {
    for key, vm in module.virtual_machines : key => vm.vm_id
  }
}

output "virtual_machine_private_ips" {
  value = {
    for key, vm in module.virtual_machines : key => vm.vm_private_ip
  }
}

output "virtual_machine_public_ips" {
  value = {
    for key, vm in module.virtual_machines : key => vm.vm_public_ip
  }
}

output "service_plan_ids" {
  value = {
    for key, sp in module.service_plans : key => sp.service_plan_id
  }
}

output "service_plan_names" {
  value = {
    for key, sp in module.service_plans : key => sp.service_plan_name
  }
}

output "web_app_names" {
  value = {
    for key, app in module.web_apps : key => app.web_app_name
  }
}

output "web_app_ids" {
  value = {
    for key, app in module.web_apps : key => app.web_app_id
  }
}

output "web_app_default_hostnames" {
  value = {
    for key, app in module.web_apps : key => app.web_app_default_hostname
  }
}

output "function_app_names" {
  value = {
    for key, func in module.function_apps : key => func.function_app_name
  }
}

output "function_app_ids" {
  value = {
    for key, func in module.function_apps : key => func.function_app_id
  }
}

output "function_app_default_hostnames" {
  value = {
    for key, func in module.function_apps : key => func.function_app_default_hostname
  }
}

output "function_app_principal_ids" {
  value = {
    for key, func in module.function_apps : key => func.function_app_principal_id
  }
}

output "application_insights_names" {
  value = {
    for key, appi in module.application_insights : key => appi.application_insights_name
  }
}

output "application_insights_ids" {
  value = {
    for key, appi in module.application_insights : key => appi.application_insights_id
  }
}

output "application_insights_connection_strings" {
  value = {
    for key, appi in module.application_insights : key => appi.connection_string
  }
  sensitive = true
}

output "data_factory_names" {
  value = {
    for key, adf in module.data_factories : key => adf.data_factory_name
  }
}

output "data_factory_ids" {
  value = {
    for key, adf in module.data_factories : key => adf.data_factory_id
  }
}

output "data_factory_principal_ids" {
  value = {
    for key, adf in module.data_factories : key => adf.data_factory_principal_id
  }
}

output "managed_identity_names" {
  value = {
    for key, mi in module.managed_identities : key => mi.managed_identity_name
  }
}

output "managed_identity_ids" {
  value = {
    for key, mi in module.managed_identities : key => mi.managed_identity_id
  }
}

output "managed_identity_client_ids" {
  value = {
    for key, mi in module.managed_identities : key => mi.managed_identity_client_id
  }
}

output "managed_identity_principal_ids" {
  value = {
    for key, mi in module.managed_identities : key => mi.managed_identity_principal_id
  }
}