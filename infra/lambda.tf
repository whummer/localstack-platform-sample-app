data "archive_file" "app" {
  type        = "zip"
  source_dir  = "${path.module}/../build/app"
  output_path = "${path.module}/../build/app.zip"
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.project_name}-lambda-exec"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "app" {
  function_name    = "${var.project_name}-api"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "app.handler.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.app.output_path
  source_code_hash = data.archive_file.app.output_base64sha256
  timeout          = 15

  environment {
    variables = {
      STRIPE_API_KEY     = var.stripe_api_key
      STRIPE_API_BASE    = var.stripe_api_base
      XERO_CLIENT_ID     = var.xero_client_id
      XERO_CLIENT_SECRET = var.xero_client_secret
      XERO_ACCESS_TOKEN  = var.xero_access_token
      XERO_TENANT_ID     = var.xero_tenant_id
      XERO_API_BASE      = var.xero_api_base
      ANTHROPIC_API_KEY  = var.anthropic_api_key
      ANTHROPIC_API_BASE = var.anthropic_api_base
    }
  }
}
