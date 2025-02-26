module "vpc" {
    source = "../../../modules/aws/network"
    project_name = "sandbox"
    azs = ["ap-south-1a", "ap-south-1b"]
    public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}


module "eks" {
    source = "../../../modules/aws/kubernetes"
    project_name = "sandbox"
    vpc_id = module.vpc.vpc_id
    public_subnets = module.vpc.public_subnets
    cluster_version = "1.28"
}