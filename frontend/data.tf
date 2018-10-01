// Current region
data "aws_region" "current" {}

data "terraform_remote_state" "tool-global" {
  backend = "remote"
  environment = "global"
}
