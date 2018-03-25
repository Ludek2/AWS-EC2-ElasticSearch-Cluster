#bastion host security group
resource "aws_security_group" "bastion" {
  description = "bastion host sg"
  name        = "bastion"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    Name = "bastion-sg"
  }
}

resource "aws_security_group_rule" "allow_egress_bastion" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "allow_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.bastion.id}"
}

#ElaseticSearch node security group
resource "aws_security_group" "node" {
  description = "ElasticSearch node sg"
  name        = "node"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    Name = "node-sg"
  }
}

resource "aws_security_group_rule" "allow_egress_node" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.node.id}"
}

resource "aws_security_group_rule" "allow_ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion.id}"
  security_group_id        = "${aws_security_group.node.id}"
}
