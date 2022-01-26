locals {

  input = {
    enabled = var.enabled == null ? var.parent.enabled : var.enabled

    // Naming
    namespace          = var.namespace == null ? var.parent.namespace : var.namespace
    environment        = var.environment == null ? var.parent.environment : var.environment
    stage              = var.stage == null ? var.parent.stage : var.stage
    name               = var.name == null ? var.parent.name : var.name
    suffix             = var.suffix == null ? [] : var.suffix
    tags               = var.tags
    short_label_length = var.short_label_length

    // IAM
    iam_permission_boundary = var.iam_permission_boundary == null ? var.parent.iam_permission_boundary : var.iam_permission_boundary
  }

  enabled = local.input.enabled

  namespace   = local.input.namespace != null ? lower(local.input.namespace) : ""
  environment = local.input.environment != null ? lower(local.input.environment) : ""
  stage       = local.input.stage != null ? lower(local.input.stage) : ""
  name        = local.input.name != null ? lower(local.input.name) : ""
  suffix      = [for suffix in concat(var.parent.suffix, var.suffix) : lower(suffix)]

  iam_permission_boundary = local.input.iam_permission_boundary

  tags = merge(
    var.parent.tags,
    # The 'name' tag is special to AWS
    { Name = local.name },

    { "spaceteams/full-label" = local.full_label },
    length(local.namespace) > 0 ? { "spaceteams/namespace" = local.namespace } : {},
    length(local.environment) > 0 ? { "spaceteams/environment" = local.environment } : {},
    length(local.stage) > 0 ? { "spaceteams/stage" = local.stage } : {},

    local.input.tags
  )

  labels = [for l in concat([local.namespace, local.environment, local.stage, local.name], local.suffix) : l if length(l) > 0]

  full_label = join("-", local.labels)

  short_label_length = max(local.input.short_label_length - 9, 0)
  short_label_prefix = trimsuffix(substr("${local.name}-${local.full_label}", 0, local.short_label_length), "-")
  short_label_suffix = substr(sha1(local.full_label), 0, 8)

  short_label = length(local.full_label) > local.short_label_length ? "${local.short_label_prefix}-${local.short_label_suffix}" : local.full_label

  label = local.short_label_length > 0 ? local.short_label : local.full_label


}
