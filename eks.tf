 data "aws_eks_cluster" "cluster" {
   name = module.eks.cluster_id
 }

 data "aws_eks_cluster_auth" "cluster" {
   name = module.eks.cluster_id
 }

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.20"
  subnets         = [var.subnet_id_1, var.subnet_id_2]
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false
  vpc_id = var.vpc_id
  cluster_endpoint_private_access_sg = [var.security_group_id]
  wait_for_cluster_timeout = 600
  cluster_create_endpoint_private_access_sg_rule = true
  cluster_endpoint_private_access_cidrs = [var.vpc_cidr_ipv4]

  tags = {
    Environment = var.environment,
    "Owner" = "search-platform-dev"
  }
  
  node_groups_defaults = {
     ami_type  = "AL2_x86_64"
     disk_size = 50
   }

   node_groups = {
     workers = {
       desired_capacity = 3
       max_capacity     = 5
       min_capacity     = 3
      
       instance_types = ["m5.xlarge"]
       k8s_labels = {
         Environment = var.environment
       }
       additional_tags = {
         ExtraTag = "workers",
         "Owner" = "search-platform-dev"
       }
     }


   }




#   map_roles    = var.map_roles
 # map_users    = var.map_users
#   map_accounts = var.map_accounts
}
