variable "name" {
  type        = string
  description = "Cluster name prefix"
}

variable "cluster_version" {
  type        = string
  description = "EKS version"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnets for control plane and nodes"
}

variable "cluster_role_arn" {
  type        = string
  description = "EKS control plane role"
}

variable "node_role_arn" {
  type        = string
  description = "Nodegroup role"
}

variable "desired_size" {
  type        = number
  description = "Desired node count"
}

variable "min_size" {
  type        = number
  description = "Minimum node count"
}

variable "max_size" {
  type        = number
  description = "Maximum node count"
}

variable "instance_types" {
  type        = list(string)
  description = "Node instance types"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
