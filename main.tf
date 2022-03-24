resource "aws_iam_role" "role" {
  name                = var.role_name
  assume_role_policy  = data.aws_iam_policy_document.role_policy.json
  managed_policy_arns = var.managed_policy_arns
}


resource "aws_ssm_parameter" "external_id" {
  name  = var.parameter_name
  type  = "SecureString"
  value = uuid()
}

resource "aws_iam_user" "user" {
  name = var.iam_username
}

resource "aws_iam_user_policy" "user_policy" {
  name   = "${var.iam_username}-policy"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.user_policy.json
}
