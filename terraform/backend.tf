terraform {
  backend "s3" {
    bucket         = "tf-state-prod"
    key            = "glue/s3-copy/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
