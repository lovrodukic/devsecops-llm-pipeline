variable "region" {
  description = "The AWS region to create resources in"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "sg_name" {
  description = "Name of security groups"
}

variable "key_name" {
  description = "Key for EC2 instance"
}
