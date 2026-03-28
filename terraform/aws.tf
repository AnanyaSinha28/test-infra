terraform {
  backend "s3" {
    bucket = "test-infra-747554529915-us-east-1-an"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}
