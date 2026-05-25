output "cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "EKS cluster endpoint"
}

output "cluster_ca_data" {
  value       = aws_eks_cluster.this.certificate_authority[0].data
  description = "EKS cluster CA"
}
