module "s3_buckets" {
  source = "./modules/s3-bucket"
}

module "lambda_function" {
  source             = "./modules/lambda"
  bucket_name        = module.s3_buckets.upload_bucket_name
  lambda_function_name = "ImageProcessingLambda"  # Define the Lambda function name here
}

module "iam_roles" {
  source                = "./modules/iam"
  lambda_role_policy_arn = module.lambda_function.lambda_role_arn
}

module "xray" {
  source               = "./modules/xray"
  lambda_function_name = module.lambda_function.lambda_function_name
}

module "cloudwatch" {
  source               = "./modules/cloudwatch"
  lambda_function_name = module.lambda_function.lambda_function_name
}
