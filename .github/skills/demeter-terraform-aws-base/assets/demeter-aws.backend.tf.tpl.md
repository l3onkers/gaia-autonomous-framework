terraform {
  backend "s3" {
    bucket         = "company-terraform-state-bucket"
    key            = "infrastructure/aws/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
