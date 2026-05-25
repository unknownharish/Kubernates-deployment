aws_region      = "us-east-1"
cluster_version = "1.29"

ecr_repositories = [
  "payment-service",
  "auth-service",
  "notification-service"
]
