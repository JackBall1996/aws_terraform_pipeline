variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources into"
}

variable "source_bucket" {
  type        = string
  description = "S3 bucket where source files arrive"
}

variable "source_bucket_prefix" {
  type        = string
  description = "Prefix inside the source bucket (no leading slash, optional)"
  default     = ""
}

variable "destination_bucket" {
  type        = string
  description = "S3 bucket where files are copied to"
}

variable "destination_bucket_prefix" {
  type        = string
  description = "Prefix inside the destination bucket (no leading slash, optional)"
  default     = ""
}

variable "glue_job_name" {
  type        = string
  description = "Name of the Glue job"
}
