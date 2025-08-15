resource "aws_instance" "server1" {
 instance_type          = "t2.micro"
 user_data              = file("setup.sh")
 subnet_id              = module.vpc.private_subnets[0]
 vpc_security_group_ids = [aws_security_group.sg1.id]
 ami                    = "ami-0f88e80871fd81e91"

 tags = {
   Name = "Webserver-1"
   env  = "dev"
   User = "Sylvain"
 }
}

resource "aws_instance" "server2" {
 instance_type          = "t2.micro"
 user_data              = file("setup.sh")
 subnet_id              = module.vpc.private_subnets[1]
 vpc_security_group_ids = [aws_security_group.sg1.id]
 ami                    = "ami-0f88e80871fd81e91"

 tags = {
   Name = "Webserver-2"
   env  = "dev"
   User = "Sylvain"
 }
}
