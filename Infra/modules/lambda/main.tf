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

resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  principal     = "s3.amazonaws.com"
  function_name = aws_lambda_function.image_processing.function_name
  source_arn    = aws_s3_bucket.upload_bucket.arn
}


output "lambda_function_name" {
  value = aws_lambda_function.image_processing.function_name
}

output "lambda_role_arn" {
  value = aws_lambda_function.image_processing.role
}

