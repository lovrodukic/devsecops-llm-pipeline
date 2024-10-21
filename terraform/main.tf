# Set AWS provider
provider "aws" {
  region = var.region
}

# Attempt to fetch details of an existing bucket
resource "aws_s3_bucket" "devsecops-llm-pipeline" {
  bucket = var.bucket_name

  tags = {
    Name        = "DevSecOps LLM Pipeline Bucket"
    Environment = "Development"
  }

  lifecycle {
    prevent_destroy = true
  }
}
