module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "sandbox-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    "kubernetes.io/role/elb"     = 1
    "kubernetes.io/cluster/sandbox-eks" = "owned"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/sandbox-eks"      = "owned"
  }

  tags = {
    Name = "sandbox-vpc"
  }
}

module "eks_blueprints" {
    source  = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.25.0"

    cluster_name    = "sandbox-eks"
    cluster_version = "1.29"
    enable_irsa     = true

    vpc_id         = module.vpc.vpc_id
    # public_subnet_ids = module.vpc.public_subnets
    private_subnet_ids = module.vpc.private_subnets

    managed_node_groups = {
      role = {
          capacity_type   = "ON_DEMAND"
          node_group_name = "general"
          instance_types  = ["t3.medium"]
          desired_size    = "1"
          max_size        = "1"
          min_size        = "1"
      }
    }
}

module "eks-blueprints-addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.20.0"
  # insert the 4 required variables here
  cluster_name      = data.aws_eks_cluster.cluster.name
  cluster_endpoint  = data.aws_eks_cluster.cluster.endpoint
  cluster_version   = data.aws_eks_cluster.cluster.version
  oidc_provider_arn = data.aws_iam_openid_connect_provider.oidc.arn

  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  enable_metrics_server                  = true
}