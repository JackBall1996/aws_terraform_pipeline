resource "aws_s3_object" "glue_script" {
  bucket = var.source_bucket
  key    = "glue/scripts/s3_copy_job.py"
  source = "${path.module}/../glue/s3_copy_job.py"
}

resource "aws_glue_job" "s3_copy" {
  name     = var.glue_job_name
  role_arn = aws_iam_role.glue_role.arn

  glue_version = "4.0"
  worker_type  = "G.1X"
  number_of_workers = 2

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${var.source_bucket}/${aws_s3_object.glue_script.key}"
  }

  default_arguments = {
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-metrics"                   = "true"
    "--job-language"                     = "python"

    "--SOURCE_BUCKET" = var.source_bucket
    "--SOURCE_PREFIX" = var.source_bucket_prefix
    "--DEST_BUCKET"   = var.destination_bucket
    "--DEST_PREFIX"   = var.destination_bucket_prefix
  }
}
