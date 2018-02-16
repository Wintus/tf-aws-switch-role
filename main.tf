variable "name" {}

variable "path" {
  default = "/switch-role/"
}

variable "base_account_id" {}

variable "policy_arn_list" {
  type = "list"

  default = []
}

# Role

resource "aws_iam_role" "switch" {
  name = "${var.name}"
  path = "${var.path}"

  description = "Allow trusted account access by assumed role"

  assume_role_policy = "${data.aws_iam_policy_document.trust_relationship.json}"
}

data "aws_iam_policy_document" "trust_relationship" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.base_account_id}:root"]
    }
  }
}

# Policy

resource "aws_iam_role_policy_attachment" "list" {
  role = "${aws_iam_role.switch.id}"

  count      = "${length(var.policy_arn_list)}"
  policy_arn = "${var.policy_arn_list[count.index]}"
}
