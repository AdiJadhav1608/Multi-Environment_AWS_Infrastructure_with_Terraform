terraform {
  backend "s3" {
    bucket       = "REPLACE_WITH_YOUR_UNIQUE_STATE_BUCKET"
    key          = "prod/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}