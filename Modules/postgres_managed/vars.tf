variable "rg" {}
variable "vnetwork" {}
variable "private_subnet" {}
variable "postgres_pass" {}
variable "tag" {}

variable "asd" {
  default = "123"
  description = "this describes the variable"
}