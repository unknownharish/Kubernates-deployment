bucket               = "prod-k8s-platform-tf-state"
key                  = "eks-platform.tfstate"
workspace_key_prefix = "states"
region               = "us-east-1"
dynamodb_table       = "prod-k8s-platform-tf-locks"
encrypt              = true