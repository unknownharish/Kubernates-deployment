output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC id"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "Private subnet ids"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "Public subnet ids"
}
