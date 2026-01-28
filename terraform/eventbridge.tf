resource "aws_cloudwatch_event_rule" "s3_object_created" {
  name = "jackball-trigger-lambda-on-s3-upload"

  event_pattern = jsonencode({
    source = ["aws.s3"]
    detail-type = ["Object Created"]
    detail = {
      bucket = {
        name = [var.source_bucket]
      }
      object = {
        key = [{
            prefix = "${var.source_bucket_prefix}"
        }]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.s3_object_created.name
  arn  = aws_lambda_function.s3_copy.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_copy.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.s3_object_created.arn
}