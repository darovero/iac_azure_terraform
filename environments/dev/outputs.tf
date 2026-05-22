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