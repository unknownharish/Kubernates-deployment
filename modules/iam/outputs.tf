output "cluster_role_arn" {
  value       = aws_iam_role.eks_cluster.arn
  description = "EKS cluster role ARN"
}

output "node_role_arn" {
  value       = aws_iam_role.eks_nodes.arn
  description = "EKS worker node role ARN"
}
