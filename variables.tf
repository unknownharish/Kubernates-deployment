variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
  default     = "1.29"
}

variable "ecr_repositories" {
  type        = list(string)
  description = "List of ECR repositories to create"
  default     = ["payment-service", "auth-service", "notification-service"]
}
