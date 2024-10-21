# Set AWS provider
provider "aws" {
  region = var.region
}

# Attempt to fetch details of an existing bucket
data "aws_s3_bucket" "devsecops-llm-pipeline" {
  bucket = var.bucket_name
}

# Create a bucket only if it does not exist
resource "aws_s3_bucket" "devsecops-llm-pipeline" {
  count  = length(data.aws_s3_bucket.devsecops-llm-pipeline.*.id) > 0 ? 0 : 1
  bucket = var.bucket_name

  tags = {
    Name        = "DevSecOps LLM Pipeline Bucket"
    Environment = "Development"
  }
}
