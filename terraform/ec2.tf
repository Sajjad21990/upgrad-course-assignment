module "bastion_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bastion"

  ami = var.ami
  instance_type = var.instance_type
  key_name = "sjd-macbook"
  vpc_security_group_ids = [module.ssh_instance_security_group.security_group_id]
  subnet_id = module.assignment_vpc.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "Bastion"
  }
}

module "jenkins_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins"

  ami = var.ami
  instance_type = var.instance_type
  key_name = "sjd-macbook"
  vpc_security_group_ids = [module.private_instance_security_group.security_group_id]
  subnet_id = module.assignment_vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "Jenkins"
  }
}

module "app_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "app"

  ami = var.ami
  instance_type = var.instance_type
  key_name = "sjd-macbook"
  vpc_security_group_ids = [module.private_instance_security_group.security_group_id]
  subnet_id = module.assignment_vpc.private_subnets[1]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "App"
  }
}