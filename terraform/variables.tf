variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources into"
}

variable "source_bucket" {
  type        = string
  description = "S3 bucket where source files arrive"
}

variable "destination_bucket" {
  type        = string
  description = "S3 bucket where files are copied to"
}

variable "glue_job_name" {
  type        = string
  description = "Name of the Glue job"
}
