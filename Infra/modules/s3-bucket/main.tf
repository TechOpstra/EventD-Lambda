resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "upload_bucket" {
  bucket = "image-upload-bucket-${random_id.bucket_suffix.hex}"
}


resource "aws_s3_bucket" "processed_bucket" {
  bucket = "processed-image-bucket-${random_id.bucket_suffix.hex}"
}


output "upload_bucket_name" {
  value = aws_s3_bucket.upload_bucket.bucket
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed_bucket.bucket
}

