resource "aws_xray_sampling_rule" "lambda_sampling_rule" {
  rule_name = "lambda-sampling-rule"
  priority  = 1
  fixed_rate = 0.05

  resource_arn = "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${var.lambda_function_name}"
}

output "xray_rule_arn" {
  value = aws_xray_sampling_rule.lambda_sampling_rule.arn
}

data "aws_caller_identity" "current" {}
