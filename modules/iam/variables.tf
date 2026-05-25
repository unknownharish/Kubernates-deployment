variable "name" {
  type        = string
  description = "Name prefix"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
