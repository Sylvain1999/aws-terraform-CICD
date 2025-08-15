// target group for ALB
resource "aws_lb_target_group" "tg1" {
 name        = "alb-tg"
 port        = 80
 protocol    = "HTTP"
 target_type = "instance"
 vpc_id      = module.vpc.vpc_id

 health_check {
   enabled             = true
   healthy_threshold   = 3
   interval            = 10
   matcher             = 200
   path                = "/"
   port                = "traffic-port"
   protocol            = "HTTP"
   timeout             = 6
   unhealthy_threshold = 3
 }
 depends_on = [module.vpc]
}

# attach instances to target group
resource "aws_lb_target_group_attachment" "tga1" {
 target_group_arn = aws_lb_target_group.tg1.arn
 target_id        = aws_instance.server1.id
 port             = 80
}

resource "aws_lb_target_group_attachment" "tga2" {
 target_group_arn = aws_lb_target_group.tg1.arn
 target_id        = aws_instance.server2.id
 port             = 80
}

# Create ALB
resource "aws_lb" "alb1" {
 name                       = "alb-lb"
 internal                   = false
 load_balancer_type         = "application"
 security_groups            = [aws_security_group.sg2.id]
 subnets                    = module.vpc.public_subnets
 enable_deletion_protection = false
}

# Create Listener
resource "aws_lb_listener" "list1" {
 load_balancer_arn = aws_lb.alb1.arn
 port              = 80
 protocol          = "HTTP"
 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.tg1.arn
 }
}
