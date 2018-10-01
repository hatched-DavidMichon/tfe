terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "hatchedlabs"

    workspaces {
      prefix = "tool-"
    }
  }
}
