locals {
  zones = {
    zone_0 = "${data.aws_region.current.name}a"
    zone_1 = "${data.aws_region.current.name}b"
    zone_2 = "${data.aws_region.current.name}c"
  }
}
