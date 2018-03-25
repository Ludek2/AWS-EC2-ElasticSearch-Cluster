data "template_file" "data-node-cloud-config" {
  template = "${ file( "./cloud-config.yml" )}"

  vars {
    node-type             = "node"
  }
}

data "template_file" "master-node-cloud-config" {
  template = "${ file( "./cloud-config.yml" )}"

  vars {
    node-type             = "master"
  }
}