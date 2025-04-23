resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "upload_bucket" {
  bucket = "image-upload-bucket-${random_id.bucket_suffix.hex}"
}


resource "aws_s3_bucket" "processed_bucket" {
  bucket = "processed-image-bucket-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_notification" "upload_bucket_notification" {
  bucket = aws_s3_bucket.upload_bucket.id

  lambda_function {
    events = ["s3:ObjectCreated:*"]
    filter {
      prefix = "uploads/"
      suffix = ".jpg"
    }

    lambda_function_arn = var.lambda_function_arn 
  }
}

output "upload_bucket_name" {
  value = aws_s3_bucket.upload_bucket.bucket
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed_bucket.bucket
}

