// Ensure the module works with the minimum setup
// of giving it just a name
module "context1" {
  source = "../../"

  name = "SomeLabelName"
}


output "context1" {
  value = {
    label       = module.context1.label
    name        = module.context1.name
    namespace   = module.context1.namespace
    environment = module.context1.environment
    stage       = module.context1.stage
  }
}

output "context1_tags" {
  value = module.context1.tags
}
