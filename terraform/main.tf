provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "devsecops-llm-pipeline" {
  bucket = var.bucket_name

  tags = {
    Name        = "DevSecOps LLM Pipeline Bucket"
    Environment = "Development"
  }
}
