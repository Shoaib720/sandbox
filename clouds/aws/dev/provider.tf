terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.88.0"
    }
    # kubernetes = {
    #   source = "hashicorp/kubernetes"
    #   version = "2.36.0"
    # }
    # helm = {
    #   source = "hashicorp/helm"
    #   version = "3.0.0-pre1"
    # }
  }
  backend "s3" {
    bucket         = "sandbox-assets-dev-24022025" # Same as created above
    key            = "terraform/state.tfstate"  # Path inside the bucket
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "sandbox-assets-lock-dev-24022025"
  }
  required_version = "~> 1.10.5"
}

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#   token = data.aws_eks_cluster_auth.cluster.token
#   # exec {
#   #   api_version = "client.authentication.k8s.io/v1beta1"
#   #   args        = ["eks", "get-token", "--cluster-name", "${var.project_name}-eks"]
#   #   command     = "aws"
#   # }
# }

# provider "helm" {
#   kubernetes {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     token                  = data.aws_eks_cluster_auth.cluster.token
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#   }
# }

provider "aws" {
  # Configuration options
}