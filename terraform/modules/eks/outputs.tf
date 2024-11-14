output "cluster_name" {
  value = aws_eks_cluster.migdal.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.migdal.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.migdal.certificate_authority[0].data
  # sensitive   = true

}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.migdal.token
  # sensitive   = true

}

