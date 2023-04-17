resource "aws_secretsmanager_secret" "secret-one" {
  name        = "secret-one"
  description = "Secret created by Terraform"
  tags = {
    dev      = "seb"
    provider = "AWS Secrets Manager"
    example  = "External Secrets Operator"
  }
}

resource "aws_secretsmanager_secret_version" "secret-one-value" {
  secret_id     = aws_secretsmanager_secret.secret-one.id
  secret_string = jsonencode(var.secret-one-value)
}

variable "secret-one-value" {
  default = {
    the-key = "Hello from AWS Secret Manager"
  }
  type = map(string)
}

resource "aws_secretsmanager_secret" "secret-two" {
  name        = "secret-two"
  description = "Secret created by Terraform"
  tags = {
    dev      = "sebastian"
    provider = "AWS Secrets Manager"
    example  = "ESO"
  }
}

resource "aws_secretsmanager_secret_version" "secret-two-value" {
  secret_id     = aws_secretsmanager_secret.secret-two.id
  secret_string = jsonencode(var.secret-two-value)
}

variable "secret-two-value" {
  default = {
    different-key = "A new AWS Secrets Manager secret"
  }
  type = map(string)
}

resource "aws_secretsmanager_secret" "three" {
  name        = "three"
  description = "Secret created by Terraform"
  tags = {
    dev      = "seb"
    provider = "AWS Secrets Manager"
    example  = "ESO"
  }
}

resource "aws_secretsmanager_secret_version" "three-value" {
  secret_id     = aws_secretsmanager_secret.three.id
  secret_string = jsonencode(var.three-value)
}

variable "three-value" {
  default = {
    key = "Third AWS Secrets Manager secret"
  }
  type = map(string)
}
