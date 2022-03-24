data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [aws_ssm_parameter.external_id.value]
    }
  }
}

data "aws_iam_policy_document" "user_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.role.arn]
  }

  statement {
    actions   = ["ssm:GetParameter*"]
    resources = [aws_ssm_parameter.external_id.arn]
  }

  statement {
    actions   = ["kms:Decrypt"]
    resources = [data.aws_kms_key.ssm.arn]

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:PARAMETER_ARN"
      values   = [aws_ssm_parameter.external_id.arn]
    }
  }
}

data "aws_kms_key" "ssm" {
  key_id = "alias/aws/ssm"
}
