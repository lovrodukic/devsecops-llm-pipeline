#!/bin/bash

BUCKET_NAME=$1

# TODO: Merge import-bucket.sh and check-bucket.sh
if aws s3api head-bucket --bucket $BUCKET_NAME 2>/dev/null; then
  echo "Bucket exists."
  echo "BUCKET_EXISTS=true" >> $GITHUB_ENV
else
  echo "Bucket does not exist."
  echo "BUCKET_EXISTS=false" >> $GITHUB_ENV
fi
