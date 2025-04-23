resource "aws_lambda_function" "image_processing" {
  function_name = "ImageProcessingLambda"
  handler       = "app.lambda_handler"
  runtime       = "python3.9"
  role          = var.lambda_execution_role_arn 
  timeout       = 60
  filename      = "./function/lambda_function.zip"

  environment {
    variables = {
      UPLOAD_BUCKET    = var.bucket_name
      PROCESSED_BUCKET = var.processed_bucket_name
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

