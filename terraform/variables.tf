variable "aws_" {
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

variable "lambda_name" {
  default = "jackball-s3-copy-lambda"
}