# Set AWS provider
provider "aws" {
  region = var.region
}

# Creation of S3 bucket
resource "aws_s3_bucket" "devsecops-llm-pipeline" {
  bucket = var.bucket_name

  tags = {
    Name        = "DevSecOps LLM Pipeline Bucket"
    Environment = "Development"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Security group to allow HTTP access
resource "aws_security_group" "app_sg" {
  name        = var.sg_name
  description = "Allow HTTP inbound traffic"

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow additional unprivileged port 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance to host application
resource "aws_instance" "app_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.app_sg.name]
  key_name        = var.key_name

  tags = {
    Name = "Flask App Instance"
  }
}
