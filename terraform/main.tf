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
    ignore_changes = [
      # List of attributes to ignore changes to (all, in this case)
      all,
    ]
    prevent_destroy = true
  }
}
