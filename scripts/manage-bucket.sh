#!/bin/bash

# Check if bucket name is provided
if [ -z "$1" ]; then
  echo "Bucket name not provided."
  exit 1
fi

BUCKET_NAME=$1

# Check if the bucket exists and import it if it does
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "Bucket exists. Importing S3 bucket: $BUCKET_NAME into Terraform state."
  terraform import aws_s3_bucket.devsecops-llm-pipeline "$BUCKET_NAME"
else
  echo "Bucket does not exist, skipping import."
fi
