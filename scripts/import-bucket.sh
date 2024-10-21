#!/bin/bash

if [ -z "$1" ]; then
  echo "Bucket name not provided."
  exit 1
fi

# Check if the bucket exists, skip import if it doesn't
BUCKET_EXISTS=$2

if [ "$BUCKET_EXISTS" == "true" ]; then
  BUCKET_NAME=$1
  echo "Importing S3 bucket: $BUCKET_NAME into Terraform state."
  terraform import aws_s3_bucket.devsecops-llm-pipeline $BUCKET_NAME
else
  echo "Bucket does not exist, skipping import."
fi
