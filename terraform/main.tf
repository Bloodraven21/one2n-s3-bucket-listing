terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5"  # Adjust this based on your needs
    }
  }
}

module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr  # Updated to use single public subnet variable
  private_subnet_cidr  = var.private_subnet_cidr
  availability_zone     = var.availability_zone
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "ecr" {
  source     = "./modules/ecr"
  repo_name  = var.repo_name
}

module "ecs" {
  source                     = "./modules/ecs"
  cluster_name               = var.cluster_name
  one2ntaskimage            = var.one2ntaskimage
  vpc_id                    = module.vpc.vpc_id
  private_subnet_id         = module.vpc.private_subnet_id
  AWS_ACCESS_KEY_ID         = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY     = var.AWS_SECRET_ACCESS_KEY
  AWS_S3_BUCKET_NAME        = var.AWS_S3_BUCKET_NAME
  AWS_REGION                = var.AWS_REGION
  public_subnet_id          = module.vpc.public_subnet_id
}