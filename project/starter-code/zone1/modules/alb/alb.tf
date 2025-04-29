resource "aws_lb_target_group" "web_group" {
  name     = "web-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/metrics"
    matcher             = "200"
  }
}

resource "aws_lb" "web_lb" {
  name               = "ubuntu-web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = true
}

resource "aws_security_group" "lb_sg" {
  name   = "lb_sg"
  vpc_id = var.vpc_id

  ingress {
    description = "web port"
    from_port   = 80
    to_port     = 80
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
    Name = "ec2_sg"
  }
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_group.arn
  }
}

resource "aws_lb_target_group_attachment" "example" {
  count = length(var.aws_instance_ids)

  target_group_arn = aws_lb_target_group.web_group.arn
  target_id        = var.aws_instance_ids[count.index]
  port             = 80
}
