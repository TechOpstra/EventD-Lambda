resource "aws_cloudwatch_dashboard" "lambda_dashboard" {
  dashboard_name = "lambda-dashboard"

  dashboard_body = jsonencode({
    "widgets": [
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 12,
        "height": 6,
        "properties": {
          "metrics": [
            [ "AWS/Lambda", "Invocations", "FunctionName", var.lambda_function_name ]
          ],
          "period": 60,
          "stat": "Sum",
          "region": var.region
        }
      }
    ]
  })
}


output "cloudwatch_dashboard_url" {
  value = "https://console.aws.amazon.com/cloudwatch/home?region=${var.region}#dashboards:name=${aws_cloudwatch_dashboard.lambda_dashboard.dashboard_name}"
}
