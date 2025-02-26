variable project_name {
  type        = string
}

variable cidr {
  type        = string
  default = "10.0.0.0/16"
}

variable azs {
  type        = list(string)
  default = ["ap-south-1a"]
}

variable public_subnets {
  type        = list(string)
  default = ["10.0.1.0/24"]
}

variable enable_nat_gateway {
  type        = bool
  default = false
}

variable enable_vpn_gateway {
  type        = bool
  default = false
}

