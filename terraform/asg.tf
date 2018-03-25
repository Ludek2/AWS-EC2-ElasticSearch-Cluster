resource "aws_launch_configuration" "data-node" {
  name_prefix = "data-node-launchconfig"

  ebs_optimized        = "true"
  image_id             = "ami-08074571"
  instance_type        = "t2.micro"
  key_name             = "${var.key_name}"

  ebs_block_device {
    device_name           = "/dev/xvdf"
    volume_size           = "8"
    volume_type           = "standard"
    delete_on_termination = true
  }

  root_block_device {
    volume_size = "8"
    volume_type = "standard"
  }

  security_groups = [
    ["${aws_security_group.node.id}"],
  ]

  user_data = "${ data.template_file.data-node-cloud-config.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "data-node" {
  name_prefix = "data-node"

  desired_capacity          = "1"
  max_size                  = "1"
  min_size                  = "1"
  health_check_grace_period = 60
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.data-node.name }"

  vpc_zone_identifier       = ["${join(",", aws_subnet.node_subnet.*.id)}"]
  enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity       = "1Minute"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["desired_capacity"]
  }

  tag {
    key                 = "ElasticSearchClusterName"
    value               = "${var.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Role"
    value               = "data-node"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "master-node" {
  name_prefix = "master-node-launchconfig"

  ebs_optimized        = "true"
  image_id             = "ami-08074571"
  instance_type        = "t2.micro"
  key_name             = "${var.key_name}"

  ebs_block_device {
    device_name           = "/dev/xvdf"
    volume_size           = "8"
    volume_type           = "standard"
    delete_on_termination = true
  }

  root_block_device {
    volume_size = "8"
    volume_type = "standard"
  }

  security_groups = [
    ["${aws_security_group.node.id}"],
  ]

  user_data = "${ data.template_file.data-node-cloud-config.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "master-node" {
  name_prefix = "master-node"

  desired_capacity          = "1"
  max_size                  = "1"
  min_size                  = "1"
  health_check_grace_period = 60
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.data-node.name }"

  vpc_zone_identifier       = ["${join(",", aws_subnet.node_subnet.*.id)}"]
  enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity       = "1Minute"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["desired_capacity"]
  }

  tag {
    key                 = "ElasticSearchClusterName"
    value               = "${var.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Role"
    value               = "master-node"
    propagate_at_launch = true
  }
}
