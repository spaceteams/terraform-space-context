// Ensure the module works with a full set of values 
module "context2" {
  source = "../../"

  name        = "Label2Name"
  namespace   = "TheCompany"
  environment = "TheProject"
  stage       = "prod"

  tags = {
    owner = "Peter"
  }
}


output "context2" {
  value = {
    label       = module.context2.label
    name        = module.context2.name
    namespace   = module.context2.namespace
    environment = module.context2.environment
    stage       = module.context2.stage
  }
}

output "context2_tags" {
  value = module.context2.tags
}
