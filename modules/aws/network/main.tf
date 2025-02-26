module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = var.cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
#   private_subnets = var.private_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = false
#   single_nat_gateway     = true
#   one_nat_gateway_per_az = false

  public_subnet_tags = {
    "kubernetes.io/role/elb"     = 1
    "kubernetes.io/cluster/sandbox-eks" = "owned"
  }

#   private_subnet_tags = {
#     "kubernetes.io/role/internal-elb" = 1
#     "kubernetes.io/cluster/sandbox"      = "owned"
#   }

  tags = {
    Name = "${var.project_name}-vpc"
  }
}