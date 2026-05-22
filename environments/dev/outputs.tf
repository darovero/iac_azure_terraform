output "resource_group_names" {
  value = module.resource_groups[*].resource_group_name
}

output "resource_group_ids" {
  value = module.resource_groups[*].resource_group_id
}