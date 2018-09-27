// Settings
variable "namespace" {
  description = "Project namespace"
}

variable "cidr_block" {
  description = "CIDR subnet range"
}

variable "public_cidr_blocks" {
  description = "List of public CIDR range per zone"
  type = "map"
}

variable "private_cidr_blocks" {
  description = "List of private CIDR range per zone"
  type = "map"
}

variable "zones" {
  description = "List of availability zones"
  type = "map"
}

// Outputs
output "public-subnet-ids" { value = ["${ aws_subnet.public-subnet.*.id }"] }
output "private-subnet-ids" { value = ["${ aws_subnet.private-subnet.*.id }"] }
output "vpc-id" { value = "${aws_vpc.vpc.id}"}
output "public-rt" { value = ["${ aws_route_table.public-rt.id }"] }
output "private-rt" { value = ["${ aws_route_table.private-rt.id }"] }
