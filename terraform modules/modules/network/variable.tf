variable "region" { type = string }
variable "azs" {type   = list(string)}

variable "vpc_cidr" {
  type        = string
}

variable "name_prefix" {
  type        = string
}

variable "enable_dns" {
  type        = bool
}

variable "enable_public_ip" {
  type        = bool
}