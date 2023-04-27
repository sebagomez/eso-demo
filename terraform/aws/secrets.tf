resource "aws_secretsmanager_secret" "secret-one" {
  name        = "secret-one"
  description = "Secret for ESO demo"
  tags = {
    dev      = "seb"
    provider = "AWS Secrets Manager"
    example  = "External Secrets Operator"
  }
}

resource "aws_secretsmanager_secret_version" "secret-one-value" {
  secret_id = aws_secretsmanager_secret.secret-one.id
  secret_string = jsonencode({
    the-key = "Hello from AWS Secret Manager"
  })
}

resource "aws_secretsmanager_secret" "secret-two" {
  name        = "secret-two"
  description = "Secret for ESO demo"
  tags = {
    dev      = "sebastian"
    provider = "AWS Secrets Manager"
    example  = "ESO"
  }
}

resource "aws_secretsmanager_secret_version" "secret-two-value" {
  secret_id = aws_secretsmanager_secret.secret-two.id
  secret_string = jsonencode({
    different-key = "A new AWS Secrets Manager secret"
  })
}

resource "aws_secretsmanager_secret" "three" {
  name        = "three"
  description = "Secret for ESO demo"
  tags = {
    dev      = "seb"
    provider = "AWS Secrets Manager"
    example  = "ESO"
  }
}

resource "aws_secretsmanager_secret_version" "three-value" {
  secret_id = aws_secretsmanager_secret.three.id
  secret_string = jsonencode({
    key = "Third AWS Secrets Manager secret"
  })
}

resource "aws_secretsmanager_secret" "access-key" {
  name        = "access-key"
  description = "Secret for ESO demo"
  tags = {
    dev      = "sebastian"
    provider = "AWS Secrets Manager"
    example  = "External Secrets Operator"
  }
}

resource "aws_secretsmanager_secret_version" "access-key-value" {
  secret_id = aws_secretsmanager_secret.access-key.id
  secret_string = jsonencode({
    id     = "AKIAIOSFODNN7EXAMPLE"
    secret = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  })
}

resource "null_resource" "terminate-secrets" {
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    working_dir = path.module
    command     = "aws secretsmanager delete-secret --secret-id secret-one --force-delete-without-recovery"
  }
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    working_dir = path.module
    command     = "aws secretsmanager delete-secret --secret-id secret-two --force-delete-without-recovery"

  }
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    working_dir = path.module
    command     = "aws secretsmanager delete-secret --secret-id three --force-delete-without-recovery"
  }
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    working_dir = path.module
    command     = "aws secretsmanager delete-secret --secret-id access-key --force-delete-without-recovery"
  }
}
