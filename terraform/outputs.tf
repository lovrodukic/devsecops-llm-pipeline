output "bucket_name" {
  value       = aws_s3_bucket.devsecops-llm-pipeline
  description = "The name of the S3 bucket"
}
