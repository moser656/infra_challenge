resource "aws_launch_configuration" "web_launch_config" {
  name          = "web-launch-configuration"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.web_key.key_name
  security_groups = [aws_security_group.web_sg.id]

  user_data = file("scripts/install_nginx.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = var.instance_count
  max_size             = 5
  min_size             = 1
  vpc_zone_identifier  = [var.subnet_id]
  launch_configuration = aws_launch_configuration.web_launch_config.name

  tag {
    key                 = "Name"
    value               = "WebASG"
    propagate_at_launch = true
  }
}
