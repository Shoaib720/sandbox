variable project_name {
  type        = string
}

variable cluster_version{
    type = string
    default = "1.27"
}

variable vpc_id {
    type = string
}

variable public_subnets {
    type = list(string)
}

variable instance_types{
    type = list(string)
    default = ["t3.medium"]
}