resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name = "vpc-${var.namespace}-${terraform.workspace}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "gw-${var.namespace}-${terraform.workspace}"
  }
}

# Allow egress connection to the rest of the internet
resource "aws_route" "internet-access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  gateway_id             = "${aws_internet_gateway.gw.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_eip" "eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.public-subnet.0.id}"

  tags {
    Name = "nat-${var.namespace}-${terraform.workspace}"
  }
}

/*
Public Subnet Separated based on AZs
*/
resource "aws_subnet" "public-subnet" {
  count = "${length(var.zones)}"
  vpc_id = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  cidr_block = "${lookup(var.public_cidr_blocks, "zone_${count.index % "${length(var.zones)}"}")}"
  availability_zone = "${lookup(var.zones, "zone_${count.index % "${length(var.zones)}"}")}"

  tags {
    Name = "${format("public-subnet-%01d", (count.index + 1))}-${var.namespace}-${terraform.workspace}"
    Tier = "public"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "public-rt-${var.namespace}-${terraform.workspace}"
  }

  depends_on = ["aws_vpc.vpc", "aws_internet_gateway.gw"]
}

resource "aws_route" "public-rt-gateway" {
  route_table_id = "${aws_route_table.public-rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gw.id}"
}

resource "aws_route_table_association" "public-rt-assoc" {
  count = "${length(var.zones)}"
  subnet_id = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

/*
Private Subnet Separated based on AZs
*/
resource "aws_subnet" "private-subnet" {
  count = "${length(var.zones)}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${lookup(var.private_cidr_blocks, "zone_${count.index % "${length(var.zones)}"}")}"
  availability_zone = "${lookup(var.zones, "zone_${count.index % "${length(var.zones)}"}")}"

  tags {
    Name = "${format("private-subnet-%01d", (count.index + 1))}-${var.namespace}-${terraform.workspace}"
    Tier = "private"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "private-rt-${var.namespace}-${terraform.workspace}"
  }

  depends_on = ["aws_vpc.vpc", "aws_nat_gateway.nat"]
}

resource "aws_route" "private-rt-nat" {
  route_table_id = "${aws_route_table.private-rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

resource "aws_route_table_association" "private-rt-assoc" {
  count = "${length(var.zones)}"
  subnet_id = "${element(aws_subnet.private-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private-rt.id}"
}
