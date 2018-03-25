output "nodes_subnet_ids" {
  value = "${join(",", aws_subnet.node_subnet.*.id)}"
}