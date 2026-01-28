terraform {
  backend "s3" {
    bucket         = "jackball-bucket/tf"
    key            = "jackball-s3-copy-lambda/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
