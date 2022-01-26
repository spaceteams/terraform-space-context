variable "parent" {
  type = any
  default = {
    enabled                 = true
    name                    = null
    namespace               = null
    environment             = null
    stage                   = null
    suffix                  = []
    tags                    = {}
    iam_permission_boundary = null
  }
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set this to false in order to disable this module"
}

variable "name" {
  type        = string
  default     = null
  description = <<EOT
    The primary name or identifier of the resource.
    It will automatically be added to the list of tags as the 'name' tag.
  EOT
}

variable "namespace" {
  type        = string
  default     = null
  description = <<EOT
    A common namespace for all resoucer, eg. a project name or a (sub-) organization.
    Feel free to use an abreviation here.
  EOT
}

variable "environment" {
  type        = string
  default     = null
  description = ""
}

variable "stage" {
  type        = string
  default     = null
  description = "Signifies the stage the resource is part of, eg. prod, staging, develop"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A set of tags added to the resource."
}

variable "suffix" {
  type        = list(string)
  default     = []
  description = "A list of suffixes to be ammended te the label."
}

variable "short_label_length" {
  type        = number
  default     = 0
  description = <<EOT
    The maximum length of the resulting lable.
    Set this for resources that have a length limit on their primary lable,
    eg. AWS Loadbalancer.
    Defaults to 0, which means unlimited.
  EOT
  validation {
    condition     = var.short_label_length >= 0
    error_message = "The short_label_length must be >= 0."
  }
}

variable "iam_permission_boundary" {
  type        = string
  default     = null
  description = "A global permission boundary ARN that will be set to all iam roles created."
}
