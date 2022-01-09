variable "aws_region" {
  default     = "ap-south-1"
  description = "AWS region"
}

variable "aws_profile" {
  default = "default"
  type = string
}

variable "cluster_name" {
  default = "eks-dev"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "4564561313"
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::769494097236:user/togi.kumar@inviz.ai"
      username = "togi.kumar@inviz.ai"
      groups   = ["system:masters"]
    },
  ]
}


variable "cluster_version" {
  default = "1.17"
  description = "CLUSTER VERSION."
  type = string
}

variable "cluster_create_timeout" {
  default = "1h"
  description = "CLUSTER CREATE TIMEOUT."
  type = string
}


variable "worker_group_name" {
  default = "worker_group"
  description = "NODEPOOL NAME." 
  type = string
}

variable "worker_group_instance_type" {
  default = "t2.micro"
  type = string
  description = "NODEPOOL INSTANCE TYPE." 
}

variable "asg_desired_count" {
  default = 1
  description = "AUTOSCALING DESIRED COUNT."  
}

variable "asg_desired_capacity" {
  default = 1
  description = "AUTOSCALING DESIRED Capacity."  
}
variable "vpc_name" {
  default = "test-vpc"
  description = "VPC NAME."  
}

variable "azs" {
  type= list(string)
  description = "list of availibility zones"  
}

variable "vpc_id" {
  type = string
  description = "VPC id to be used"
}

variable "subnet_id_1" {
  type = string
  description = "list of availibility zones"
}

variable "subnet_id_2" {
  default = "default"
  type = string
}

variable "security_group_id" {
  default = "default"
  type = string
}

variable "environment" {
  default = "default"
  type = string
}

variable "vpc_cidr_ipv4" {
  default = "default"
  type = string
}

variable "privsub_cidr_1a" {
  default = "default"
  type = string
}

variable "privsub_cidr_1b" {
  default = "default"
  type = string
}

variable "privsub_cidr_1c" {
  default = "default"
  type = string
}

variable "transit_gw" {
  default = "default"
  type = string
}

variable "nat_gw" {
  default = "default"
  type = string
}

variable "az_1" {
  default = "default"
  type = string
}

variable "az_2" {
  default = "default"
  type = string
}

variable "az_3" {
  default = "default"
  type = string
}

variable "route_tb_id_1b" {
  default = "default"
  type = string
}

