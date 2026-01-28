data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "s3_copy" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "s3_copy_job.handler"
  runtime       = "python3.11"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      DEST_BUCKET  = var.destination_bucket
      DEST_PREFIX  = var.destination_bucket_prefix
      SOURCE_BUCKET = var.source_bucket
      SOURCE_PREFIX = var.source_bucket_prefix
    }
  }
}
