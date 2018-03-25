resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"

  tags {
    Name              = "${var.vpc_name}"
  }
}

resource "aws_subnet" "node_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(split(",", var.aws["azs"]))}"
  availability_zone       = "${element( split(",", var.aws["azs"] ), count.index )}"
  cidr_block              = "${element( split(",", var.node_cidr), count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name                              = "node-subnet"
  }
}

