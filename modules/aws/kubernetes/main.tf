module "eks" {
    source  = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.25.0"
    #   version = ">= 4.0.0"

    cluster_name    = "${var.project_name}-eks"
    cluster_version = var.cluster_version
    enable_irsa     = true

    vpc_id         = var.vpc_id
    public_subnet_ids = var.public_subnets

    managed_node_groups = {
        default = {
            capacity_type   = "ON_DEMAND"
            node_group_name = "${var.project_name}"
            instance_types  = var.instance_types
            desired_size    = "1"
            max_size        = "1"
            min_size        = "1"
        }
    }
}

# module "eks_blueprints" {
#   source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.2"

#   # EKS Cluster VPC and Subnet mandatory config
#   vpc_id             = <vpc_id>
#   private_subnet_ids = <private_subnet_ids>

#   # EKS CLUSTER VERSION
#   cluster_version = "1.21"

#   # EKS MANAGED NODE GROUPS
#   managed_node_groups = {
#     mg_5 = {
#       node_group_name = "managed-ondemand"
#       instance_types  = ["m5.large"]
#       min_size        = "2"
#     }
# }