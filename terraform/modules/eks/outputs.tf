output "cluster_name" {
  value = aws_eks_cluster.demo.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.demo.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.demo.certificate_authority[0].data
  # sensitive   = true

}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.demo.token
  # sensitive   = true

}

#demo.certificate_authority[0].data