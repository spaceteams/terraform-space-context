// Ensure that stacks are ammended
module "context5" {
  source = "../../"

  name   = "SomeLabelName"
  suffix = ["suffix1"]

  iam_permission_boundary = "boundary1"
}

module "context51" {
  source = "../../"

  parent = module.context5
  suffix = ["suffix2"]

  iam_permission_boundary = "boundary2"
}


output "context5" {
  value = module.context5
}

output "context51" {
  value = module.context51
}
