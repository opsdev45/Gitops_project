provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./modules/vpc"

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

}

module "eks" {
  source = "./modules/eks"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "argocd" {
  source           = "./modules/argocd"
  
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca       = module.eks.cluster_ca
  cluster_token    = module.eks.cluster_token
}