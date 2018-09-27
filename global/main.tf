provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

module "vpc" {
  source = "../shared/modules/vpc"

  namespace = "${ var.namespace }"
  cidr_block = "${ var.cidr_block }"
  public_cidr_blocks = "${ var.public_cidr_blocks }"
  private_cidr_blocks = "${ var.private_cidr_blocks }"
  zones = "${ local.zones }"
}

module "iam" {
  source = "../shared/modules/iam"

  namespace = "${ var.namespace }"
}
