resource "aws_iam_user" "eso-user" {
  name = "external-secrets"
}

resource "aws_iam_access_key" "eso" {
  user = aws_iam_user.eso-user.name
}

data "aws_iam_policy_document" "eso-policy-doc" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "eso-policy" {
  name   = "eso-policy"
  user   = aws_iam_user.eso-user.name
  policy = data.aws_iam_policy_document.eso-policy-doc.json
}

output "access_key_id" {
  value     = aws_iam_access_key.eso.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.eso.secret
  sensitive = true
}
