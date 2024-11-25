resource "aws_lb" "ecs_lb" {
  name               = "${var.env}-ecs-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ecs_sg]
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "ecs_tg" {
  name     = "${var.env}-ecs-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/actuator/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "ecs_tg_attachment" {
  count            = length(var.ecs_instance_id)
  target_group_arn  = aws_lb_target_group.ecs_tg.arn
  target_id        = var.ecs_instance_id[count.index]
  port              = var.container_port
}


