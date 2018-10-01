terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "hatchedlabs"

    workspaces {
      name = "tool-global"
    }
  }
}
