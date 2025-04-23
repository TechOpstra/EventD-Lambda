variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
