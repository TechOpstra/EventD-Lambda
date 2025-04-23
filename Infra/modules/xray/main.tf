resource "aws_xray_sampling_rule" "lambda_sampling_rule" {
  rule_name          = "LambdaSamplingRule"
  service_name       = "ImageProcessingLambda"  # Use your Lambda function's name or another service name
  service_type       = "AWS_LAMBDA"  # Use "AWS_LAMBDA" for Lambda functions
  resource_arn       = "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${var.lambda_function_name}"
  http_method        = "*"  # Specify the HTTP method (e.g., "*" for all, or specify a particular method like "GET")
  reservoir_size     = 1  # Adjust the reservoir size based on your needs
  host               = "localhost"  # Specify the host; usually "localhost" for Lambda
  url_path           = "/"  # URL path (you can change it based on your use case)
  version            = 1  # Version of the sampling rule
}


output "xray_rule_arn" {
  value = aws_xray_sampling_rule.lambda_sampling_rule.arn
}

data "aws_caller_identity" "current" {}
