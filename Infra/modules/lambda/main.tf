resource "aws_lambda_function" "image_processing" {
  function_name = "ImageProcessingLambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  role          = module.iam_roles.lambda_execution_role_arn
  timeout       = 60
  filename      = "./lambda_function/lambda_function.zip"

  environment {
    variables = {
      UPLOAD_BUCKET    = var.bucket_name
      PROCESSED_BUCKET = module.s3_buckets.processed_bucket_name
    }
  }

  tracing_config {
    mode = "Active"
  }
}


output "lambda_function_name" {
  value = aws_lambda_function.image_processing.function_name
}

output "lambda_role_arn" {
  value = aws_lambda_function.image_processing.role
}

output "lambda_function_name" {
  value = aws_lambda_function.image_processing.function_name
}

output "lambda_role_arn" {
  value = aws_lambda_function.image_processing.role
}
