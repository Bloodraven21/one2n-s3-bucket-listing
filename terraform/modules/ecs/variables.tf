variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "one2ntaskimage" {
  description = "The Docker image for the one2ntask service."
  type        = string
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID for the application."
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key for the application."
  type        = string
}

variable "AWS_S3_BUCKET_NAME" {
  description = "The name of the S3 bucket used by the application."
  type        = string
}

variable "AWS_REGION" {
  description = "The AWS region where resources will be created."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where ECS resources will be deployed."
  type        = string
}

variable "private_subnet_id" {
  description = "The private subnet ID for the ECS service."
  type        = string
}

variable "public_subnet_id" {
  description = "The private subnet ID for the ECS service."
  type        = string
}