variable "key_name" {
  default = "elastic"
}

variable "cluster_name" {
  default = "cluster1"
}

variable "vpc_name" {
  default = "elasticsearch_vpc"
}

variable "aws" {
  type = "map"

  default = {
    azs    = "eu-west-1a,eu-west-1b,eu-west-1c"
    region = "eu-west-1"
  }
}
variable "vpc_cidr"{
  default= "10.0.0.0/16"
}
variable "node_cidr" {
  default = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
}