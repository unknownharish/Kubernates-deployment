variable "repositories" {
  type        = list(string)
  description = "List of ECR repositories to create"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
