output "bucket_name" {
  value       = aws_s3_bucket.devsecops-llm-pipeline
  description = "The name of the S3 bucket"
}

output "instance_public_ip" {
  value       = aws_instance.app_instance.public_ip
  description = "Public IP of the EC2 instance for the Flask app"
}
