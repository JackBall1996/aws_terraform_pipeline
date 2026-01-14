terraform {
  backend "s3" {
    bucket         = "jackball-bucket/tf"
    key            = "glue/s3-copy/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
