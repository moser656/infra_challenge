resource "aws_elb" "web_elb" {
  name               = "web-elb"
  availability_zones = ["us-west-2a", "us-west-2b"]
  security_groups    = [aws_security_group.web_sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 443
    lb_protocol       = "HTTPS"
    ssl_certificate_id = data.aws_acm_certificate.web_ssl_certificate.arn
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances = aws_instance.web_instance.*.id

  tags = {
    Name = "WebELB"
  }
}

data "aws_acm_certificate" "web_ssl_certificate" {
  domain   = "yourdomain.com"
  statuses = ["ISSUED"]
}
