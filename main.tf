terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  environment_configs = {
    dev = {
      vpc_cidr             = "10.10.0.0/16"
      public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
      private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24"]
      az_count             = 2
      instance_types       = ["t3.large"]
      desired_size         = 2
      min_size             = 2
      max_size             = 4
    }

    stage = {
      vpc_cidr             = "10.20.0.0/16"
      public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
      private_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
      az_count             = 2
      instance_types       = ["m5.large"]
      desired_size         = 3
      min_size             = 2
      max_size             = 6
    }

    prod = {
      vpc_cidr             = "10.30.0.0/16"
      public_subnet_cidrs  = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
      private_subnet_cidrs = ["10.30.11.0/24", "10.30.12.0/24", "10.30.13.0/24"]
      az_count             = 3
      instance_types       = ["m5.xlarge"]
      desired_size         = 4
      min_size             = 3
      max_size             = 12
    }
  }

  current_env_name = terraform.workspace

  # Keep expressions valid even for unexpected workspaces; check block below enforces allowed names.
  current_env = contains(keys(local.environment_configs), local.current_env_name) ? local.environment_configs[local.current_env_name] : local.environment_configs["dev"]

  name = "platform-${local.current_env_name}"

  tags = {
    Environment = local.current_env_name
    Project     = "production-k8s-platform"
    ManagedBy   = "terraform"
  }
}

check "allowed_workspace" {
  assert {
    condition     = contains(keys(local.environment_configs), terraform.workspace)
    error_message = "Unsupported workspace '${terraform.workspace}'. Use one of: dev, stage, prod."
  }
}

module "vpc" {
  source = "./modules/vpc"

  name                 = local.name
  cidr_block           = local.current_env.vpc_cidr
  azs                  = slice(data.aws_availability_zones.available.names, 0, local.current_env.az_count)
  public_subnet_cidrs  = local.current_env.public_subnet_cidrs
  private_subnet_cidrs = local.current_env.private_subnet_cidrs
  tags                 = local.tags
}

module "iam" {
  source = "./modules/iam"

  name = local.name
  tags = local.tags
}

module "eks" {
  source = "./modules/eks"

  name               = local.name
  cluster_version    = var.cluster_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  cluster_role_arn   = module.iam.cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  desired_size       = local.current_env.desired_size
  min_size           = local.current_env.min_size
  max_size           = local.current_env.max_size
  instance_types     = local.current_env.instance_types
  tags               = local.tags
}

module "ecr" {
  source = "./modules/ecr"

  repositories = var.ecr_repositories
  tags         = local.tags
}
