// Ensure the module works with an inheritace from a parent
module "context3" {
  source = "../../"

  name = "Label3Name"

  tags = {
    value = "true"
  }

  parent = module.context2
}


output "context3" {
  value = {
    label       = module.context3.label
    name        = module.context3.name
    namespace   = module.context3.namespace
    environment = module.context3.environment
    stage       = module.context3.stage
  }
}

output "context3_tags" {
  value = module.context3.tags
}
