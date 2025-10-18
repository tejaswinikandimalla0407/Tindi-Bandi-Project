variable "region" {}
variable "azs" { type = list(string) }
variable "vpc_cidr" {}
variable "name_prefix" {}
variable "enable_dns" { type = bool }
variable "enable_public_ip" { type = bool }
variable "cluster_name" {}
variable "node_desired_size" {}
variable "node_min_size" {}
variable "node_max_size" {}
variable "instance_type" {}
variable "key_name" {}
variable "ami_id" {}