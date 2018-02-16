variable "name" {}

variable "path" {
  default = "/switch-role/"
}

variable "base_account_id" {}

variable "policy_arn_list" {
  type = "list"

  default = []
}
