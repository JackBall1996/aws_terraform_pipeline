resource "aws_cloudwatch_event_rule" "s3_object_created" {
  name = "jackball-trigger-glue-on-s3-upload"

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

resource "aws_cloudwatch_event_target" "trigger_glue_workflow" {
  rule = aws_cloudwatch_event_rule.s3_object_created.name
  arn  = aws_glue_workflow.s3_copy_workflow.arn

  role_arn = aws_iam_role.eventbridge_invoke_glue_role.arn
}