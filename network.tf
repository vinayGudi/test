#### Creating Private Subnets


#### Creating Route Table For Private Subnet

 resource "aws_route_table" "private_rt" {
   vpc_id = var.vpc_id

   tags = {
     Name = "search-private-rt-${var.environment}",
     "Owner" = "search-platform-dev"
   }
 }

#### Creating Route Table Association For Private Subnets

 resource "aws_route_table_association" "private_rt_ass_1a" {
   subnet_id      = var.subnet_id_1
   route_table_id = aws_route_table.private_rt.id
 }

 resource "aws_route_table_association" "private_rt_ass_1b" {
   subnet_id      = var.subnet_id_2
   route_table_id = aws_route_table.private_rt.id
 }

 #todo nat gatewat association for routetable
 
 resource "aws_route_table_association" "transit_gt_ass" {
   gateway_id     = var.nat_gw
   route_table_id = aws_route_table.private_rt.id
 }

#### Creating Security Groups

resource "aws_security_group" "vpcep-sg" {
  description = "Security group to govern who can access the endpoints"
  vpc_id      = var.vpc_id
  tags = {
    "Name" = format("eks-%s-cluster/ControlPlaneSecurityGroup",var.cluster_name),
    "Label" = "TF-EKS Control Plane & all worker nodes comms",
    "Owner" = "search-platform-dev"
  }
}

resource "aws_security_group_rule" "eks-all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr_ipv4]
  security_group_id = aws_security_group.vpcep-sg.id
}

resource "aws_security_group_rule" "eks-all-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.vpcep-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

#### Creating VPC Endpoints: [ec2, ecr.api, ecr.dkr, s3]

resource "aws_vpc_endpoint" "vpce-ec2" {
  service_name = format("com.amazonaws.%s.ec2",var.aws_region)
  vpc_endpoint_type = "Interface"
  vpc_id            = var.vpc_id
  private_dns_enabled = true
  security_group_ids = [aws_security_group.vpcep-sg.id]
  subnet_ids = [
    var.subnet_id_1,
    var.subnet_id_2
  ]
  tags = {
    Name = "search-ec2-ep",
    Environment = var.environment,
    "Owner" = "search-platform-dev"
  }
}

resource "aws_vpc_endpoint" "vpce-ecrapi" {
  service_name = format("com.amazonaws.%s.ecr.api",var.aws_region)
  vpc_endpoint_type = "Interface"
  vpc_id            = var.vpc_id
  private_dns_enabled = true
  security_group_ids = [aws_security_group.vpcep-sg.id]
  subnet_ids = [
    var.subnet_id_1,
    var.subnet_id_2
  ]
  tags = {
    Name = "search-ecrAPI-ep",
    Environment = var.environment,
    "Owner" = "search-platform-dev"
  }
}

resource "aws_vpc_endpoint" "vpce-ecrdkr" {
  service_name = format("com.amazonaws.%s.ecr.dkr",var.aws_region)
  vpc_endpoint_type = "Interface"
  vpc_id            = var.vpc_id
  private_dns_enabled = true
  security_group_ids = [aws_security_group.vpcep-sg.id]
  subnet_ids = [
    var.subnet_id_1,
    var.subnet_id_2
  ]
  tags = {
    Name = "search-ecrDkr-ep",
    Environment = var.environment,
    "Owner" = "search-platform-dev"
  }
}

#resource "aws_vpc_endpoint" "vpce-s3" {
#  service_name = format("com.amazonaws.%s.s3",var.aws_region)
#  vpc_endpoint_type  = "Gateway"
#  vpc_id            = var.vpc_id
#  private_dns_enabled = false
#  route_table_ids = [
#    var.route_tb_id_1b
#  ]
#  tags = {
#    Name = "search-s3-ep",
#    Environment = var.environment,
#    "Owner" = "search-platform-dev"
#  }
#}

resource "aws_vpc_endpoint" "vpce-autoscaling" {
  service_name = format("com.amazonaws.%s.autoscaling",var.aws_region)
  vpc_endpoint_type = "Interface"
  vpc_id            = var.vpc_id
  private_dns_enabled = true
  security_group_ids = [aws_security_group.vpcep-sg.id]
  subnet_ids = [
    var.subnet_id_1,
    var.subnet_id_2
  ]
  tags = {
    Name = "search-autoscaling-ep",
    Environment = var.environment,
    "Owner" = "search-platform-dev"
  }
}
