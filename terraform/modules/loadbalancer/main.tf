resource "aws_lb" "main" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids
}

# Frontend Target Group
resource "aws_lb_target_group" "frontend" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" # 'ip' is recommended for awsvpc network mode
}

# Backend Target Group
resource "aws_lb_target_group" "backend" {
  name     = "backend-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
}

# Listeners
resource "aws_lb_listener" "http_frontend" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_listener" "http_backend" {
  load_balancer_arn = aws_lb.main.arn
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}