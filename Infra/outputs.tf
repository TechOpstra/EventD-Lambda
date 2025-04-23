output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = module.lambda_function.lambda_function_name
}

output "upload_bucket_name" {
  description = "The name of the S3 bucket for image uploads"
  value       = module.s3_buckets.upload_bucket_name
}

output "processed_bucket_name" {
  description = "The name of the S3 bucket for processed images"
  value       = module.s3_buckets.processed_bucket_name
}

output "cloudwatch_dashboard_url" {
  description = "The URL for the CloudWatch dashboard"
  value       = module.cloudwatch.cloudwatch_dashboard_url
}
