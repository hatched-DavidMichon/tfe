// Settings
variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "aws_region" {
  description = "AWS Region"
}

variable "namespace" {
  description = "Namespace"
}

variable "cidr_block" {
  default = "10.30.0.0/16"
}

variable "public_cidr_blocks" {
  default = {
    zone_0 = "10.30.0.0/24"
    zone_1 = "10.30.2.0/24"
    zone_2 = "10.30.4.0/24"
  }
}

variable "private_cidr_blocks" {
  default = {
    zone_0 = "10.30.1.0/24"
    zone_1 = "10.30.3.0/24"
    zone_2 = "10.30.5.0/24"
  }
}

// Outputs
output "namespace" { value = "${ var.namespace }" }
