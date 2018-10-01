provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

module "vpc" {
  source = "app.terraform.io/hatchedlabs/vpc/aws"
  //version = "0.0.2"

  namespace = "${ var.namespace }"
  cidr_block = "${ var.cidr_block }"
  public_cidr_blocks = "${ var.public_cidr_blocks }"
  private_cidr_blocks = "${ var.private_cidr_blocks }"
  zones = "${ local.zones }"
}
