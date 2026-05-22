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