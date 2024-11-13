variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}


variable "cluster_ca" {
  description = "The certificate authority data of the EKS cluster."
  type        = string
}

variable "cluster_token" {
  description = "The authentication token for accessing the EKS cluster."
  type        = string
}