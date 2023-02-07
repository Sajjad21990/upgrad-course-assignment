module "ssh_instance_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "Bastion Instance"
  description = "Allow self ip to ssh to bastion instance and allow all egress."
  vpc_id = module.assignment_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = ["all-all"]
}

module "private_instance_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "Private Instances"
  description = "Allow all incoming traffic from within VPC and all egress."
  vpc_id = module.assignment_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = module.assignment_vpc.vpc_cidr_block    
    }
  ]

  egress_rules = ["all-all"]
}

module "public_instance_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "Public Instances"
  description = "Allow incoming to port 80 from self IP and all egress."
  vpc_id = module.assignment_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = ["all-all"]
}




