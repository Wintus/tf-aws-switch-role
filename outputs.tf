output "arn" {
  value = "${aws_iam_role.switch.arn}"
}

output "url" {
  # roleName は path_name/role_name しか受け付けないので、頭の / を削る
  value = "${join("", list("https://signin.aws.amazon.com/switchrole"
    , "?roleName=", substr(aws_iam_role.switch.path, 1, -1), aws_iam_role.switch.id
    ))}"
}
