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
  terraform import -var="ami_id=${AMI_ID}" -var="region=${AWS_REGION}" \
    -var="bucket_name=${BUCKET_NAME}" -var="instance_type=${INSTANCE_TYPE}" \
    -var="sg_name=${SG_NAME}" -var="key_name=${KEY_NAME}" \
    aws_s3_bucket.app_bucket "$BUCKET_NAME"
else
  echo "Bucket does not exist, skipping import."
fi
