// Current region
data "aws_region" "current" {}

data "terraform_remote_state" "tool-global" {
  backend = "atlas"
  config {
    name = "hatchedlabs/tool-global"
  }
}
