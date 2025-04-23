resource "aws_s3_bucket" "upload_bucket" {
  bucket = "image-upload-bucket-${random_id.bucket_suffix.hex}"
  acl    = "private"
}

resource "aws_s3_bucket" "processed_bucket" {
  bucket = "processed-image-bucket-${random_id.bucket_suffix.hex}"
  acl    = "private"
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}



output "upload_bucket_name" {
  value = aws_s3_bucket.upload_bucket.bucket
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed_bucket.bucket
}

