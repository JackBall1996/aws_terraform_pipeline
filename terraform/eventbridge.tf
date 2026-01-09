resource "aws_cloudwatch_event_rule" "s3_object_created" {
  name = "jackball-trigger-glue-on-s3-upload"

  event_pattern = jsonencode({
    source = ["aws.s3"]
    detail-type = ["Object Created"]
    detail = {
      bucket = {
        name = [var.source_bucket]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "trigger_glue_job" {
  rule = aws_cloudwatch_event_rule.s3_object_created.name
  arn  = aws_glue_job.s3_copy.arn
  role_arn = aws_iam_role.glue_role.arn

  input_transformer {
    input_paths = {
      bucket = "$.detail.bucket.name"
      key    = "$.detail.object.key"
    }

    input_template = <<EOF
{
  "--SOURCE_BUCKET": "<bucket>",
  "--SOURCE_KEY": "<key>",
  "--DEST_BUCKET": "${var.destination_bucket}"
}
EOF
  }
}
