variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "repo_name" {
  description = "ECR repository name"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "one2ntask_image" {
  description = "Docker image for the one2ntask service"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to associate with the ECS service"
  type        = string
}

variable "AWS_S3_BUCKET_NAME" {
  description = "AWS Access Key ID"
  type        = string
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID"
  type        = string
}

variable "AWS_REGION" {
  description = "AWS Secret Access Key"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key"
  type        = string
}

variable "one2ntask_lock_dynamodb_table" {
  description = "DynamoDB table for locking state"
  type        = string
}

variable "one2ntask_tf_remote_state" {
  description = "Remote state configuration for one2ntask"
  type        = string
}

variable "one2ntask_security_group" {
  description = "Security group for the one2ntask service"
  type        = string
}

# Removed ALB-related variable as it's no longer needed.
# variable "alb_security_group" {
#   type        = string
# }

variable "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "one2ntaskimage" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "public_subnet_id" {
  description = "The private subnet ID for the ECS service."
  type        = string
}