variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-west-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  default     = "devsecops-llm-pipeline"
}
