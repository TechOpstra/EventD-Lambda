resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_s3_policy"
  description = "Allow Lambda function to access S3"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals = [
      {
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    ]
  }
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*",
      "arn:aws:s3:::${module.s3_buckets.processed_bucket_name}/*"
    ]
  }
}

output "lambda_execution_role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}
