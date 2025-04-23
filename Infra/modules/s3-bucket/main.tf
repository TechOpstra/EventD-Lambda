resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "upload_bucket" {
  bucket = "image-upload-bucket-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_acl" "upload_bucket_acl" {
  bucket = aws_s3_bucket.upload_bucket.bucket
  acl    = "private"
}

resource "aws_s3_bucket" "processed_bucket" {
  bucket = "processed-image-bucket-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_acl" "processed_bucket_acl" {
  bucket = aws_s3_bucket.processed_bucket.bucket
  acl    = "private"
}



output "upload_bucket_name" {
  value = aws_s3_bucket.upload_bucket.bucket
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed_bucket.bucket
}

