variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
