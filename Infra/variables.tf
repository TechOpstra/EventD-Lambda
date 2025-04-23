variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "upload_bucket_name" {
  description = "Name of the S3 bucket for image uploads"
  type        = string
}

variable "processed_bucket_name" {
  description = "Name of the S3 bucket for processed images"
  type        = string
}

