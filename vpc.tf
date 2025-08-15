resource "aws_security_group" "sg1" {
 name        = "webserver-sg"
 description = "Allow http"
 vpc_id      = module.vpc.vpc_id

 ingress {
   description = "allow http"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   security_groups = [aws_security_group.sg2.id]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
   env                  = "Dev"
   created-by-terraform = "yes"
   User = "Sylvain"
 }
}

resource "aws_security_group" "sg2" {
 name        = "alb-sg"
 description = "Allow http and https"
 vpc_id      = module.vpc.vpc_id

 ingress {
   description = "allow http"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   description = "allow https"
   from_port   = 443
   to_port     = 443
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
   env                  = "Dev"
   created-by-terraform = "yes"
   User = "Sylvain"
 }
}

module "vpc" {
 source = "terraform-aws-modules/vpc/aws"

 name = "alb-vpc"
 cidr = "10.0.0.0/16"

 azs             = ["us-east-1a", "us-east-1b"]
 private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
 public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

 enable_nat_gateway = true
 enable_vpn_gateway = false
 single_nat_gateway = true

 tags = {
   Terraform   = "true"
   Environment = "dev"
   User = "Sylvain"
 }
}
