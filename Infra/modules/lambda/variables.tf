variable "bucket_name" {
  description = "Name of the S3 bucket for image upload"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_execution_role_arn" {
  description = "The ARN of the Lambda execution role"
  type        = string
}

variable "processed_bucket_name" {
  description = "The name of the processed S3 bucket"
  type        = string
}
