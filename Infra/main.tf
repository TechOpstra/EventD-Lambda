module "s3_buckets" {
  source = "./modules/s3-bucket"
}

module "lambda_function" {
  source                  = "./modules/lambda"
  bucket_name             = module.s3_buckets.upload_bucket_name
  lambda_function_name    = "ImageProcessingLambda"
  lambda_execution_role_arn = module.iam_roles.lambda_execution_role_arn  # Pass ARN here
}

module "iam_roles" {
  source             = "./modules/iam"
  upload_bucket_name = module.s3_buckets.upload_bucket_name  # Pass the upload bucket name
  processed_bucket_name = module.s3_buckets.processed_bucket_name  # Pass the processed bucket name
}

module "xray" {
  source               = "./modules/xray"
  lambda_function_name = module.lambda_function.lambda_function_name
}

module "cloudwatch" {
  source               = "./modules/cloudwatch"
  lambda_function_name = module.lambda_function.lambda_function_name
}
