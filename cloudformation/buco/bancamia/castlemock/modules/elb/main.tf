resource "aws_lb" "alb" {
   name                 = "${var.prefix}-alb"
   internal             = false
   load_balancer_type   = "application"
   security_groups      = [var.castlemock_alb_sg]
   subnets              = data.aws_subnets.public_subnets.ids

   tags = {
      Name = "${var.prefix}-alb"
   }
}

resource "aws_lb_target_group" "tg" {
   name        = "${var.prefix}-tg"
   target_type = "ip"
   port        = 80
   protocol    = "HTTP"
   vpc_id      = var.vpc_id

   health_check {
     enabled   = true
     path      = "/root/.castlemock"
     interval  = 300
   }

   tags = {
      Name = "${var.prefix}-tg"
   }
}

resource "aws_lb_listener" "http" {
   load_balancer_arn = aws_lb.alb.arn
   port              = 80
   protocol          = "HTTP"

   default_action {
     type               = "forward"
     target_group_arn   = aws_lb_target_group.tg.arn
   }
}