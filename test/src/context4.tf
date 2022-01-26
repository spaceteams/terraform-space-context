// Ensure the module shortens labels when necessary
module "context4" {
  source = "../../"

  name               = "Label4NameXX"
  parent             = module.context3
  short_label_length = 20
}


output "context4" {
  value = {
    label       = module.context4.label
    name        = module.context4.name
    namespace   = module.context4.namespace
    environment = module.context4.environment
    stage       = module.context4.stage
  }
}

output "context4_tags" {
  value = module.context4.tags
}
