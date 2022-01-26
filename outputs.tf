output "label" {
  value       = local.enabled ? local.label : ""
  description = "Resulting generated label string"
}

output "enabled" {
  value       = local.enabled
  description = "True if module is enabled, false otherwise"
}

output "name" {
  value       = local.enabled ? local.name : ""
  description = "The name part of this label"
}

output "namespace" {
  value       = local.enabled ? local.namespace : ""
  description = "The namespace part of this label"
}

output "environment" {
  value       = local.enabled ? local.environment : ""
  description = "The environment part of this label"
}

output "stage" {
  value       = local.enabled ? local.stage : ""
  description = "The stage part of this label"
}

output "tags" {
  value       = local.enabled ? local.tags : {}
  description = "Generated tag map of this label"
}

output "suffix" {
  value       = local.enabled ? local.suffix : []
  description = "Additional suffixes that are appended to the ID. Suffixes stack when passing a parent context."
}

output "iam_permission_boundary" {
  value       = local.enabled ? local.iam_permission_boundary : null
  description = "Global permission boundary ARN that is passed to the IAM roles in context."
}
