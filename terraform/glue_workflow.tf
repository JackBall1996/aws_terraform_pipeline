resource "aws_glue_workflow" "s3_copy_workflow" {
  name = "jackball-s3-copy-workflow"
}

resource "aws_glue_trigger" "s3_copy_trigger" {
  name          = "jackball-s3-copy-trigger"
  type          = "ON_DEMAND"
  workflow_name = aws_glue_workflow.s3_copy_workflow.name

  actions {
    job_name = aws_glue_job.s3_copy.name
  }
}
