resource "aws_ssm_parameter" "secret-one" {
  name        = "secret-one"
  description = "Parameter for ESO demo"
  type        = "SecureString"
  value       = "{\"the-key\":\"Hello from AWS Parameter Store\"}"

  tags = {
    dev      = "seb"
    provider = "AWS Parameter Store"
    example  = "External Secrets Operator"
  }
}

resource "aws_ssm_parameter" "secret-two" {
  name        = "secret-two"
  description = "Parameter for ESO demo"
  type        = "SecureString"
  value       = "{\"different-key\":\"A new AWS Parameter Store secret\"}"

  tags = {
    dev      = "sebastian"
    provider = "AWS Parameter Store"
    example  = "ESO"
  }
}

resource "aws_ssm_parameter" "three" {
  name        = "three"
  description = "Parameter for ESO demo"
  type        = "SecureString"
  value       = "{\"key\":\"Third AWS Parameter Store secret\"}"

  tags = {
    dev      = "seb"
    provider = "AWS Parameter Store"
    example  = "ESO"
  }
}
