#!/bin/bash

# Exit immediately if any command fails
set -e

# Run Terraform Plan
echo "Running terraform plan..."
terraform plan -var="region=${AWS_REGION}" -var="ami_id=${AMI_ID}" \
  -var="bucket_name=${BUCKET_NAME}" -var="instance_type=${INSTANCE_TYPE}" \
  -var="sg_name=${SG_NAME}" -var="key_name=${KEY_NAME}"

# Run Terraform Apply
if [ "$1" == "apply" ]; then
  echo "Running terraform apply..."
  terraform apply -auto-approve -var="region=${AWS_REGION}" \
    -var="ami_id=${AMI_ID}" -var="bucket_name=${BUCKET_NAME}" \
    -var="instance_type=${INSTANCE_TYPE}" -var="sg_name=${SG_NAME}" \
    -var="key_name=${KEY_NAME}"
fi
