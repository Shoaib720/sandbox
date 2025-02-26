terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.88.0"
    }
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
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", "${var.project_name}-eks"]
#     command     = "aws"
#   }
# }

provider "aws" {
  # Configuration options
}