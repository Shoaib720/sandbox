module "eks" {
    source  = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.25.0"
    #   version = ">= 4.0.0"

    cluster_name    = "${var.project_name}-eks"
    cluster_version = var.cluster_version
    enable_irsa     = true

    vpc_id         = var.vpc_id
    private_subnet_ids = var.public_subnets

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