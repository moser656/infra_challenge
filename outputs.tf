output "elb_dns_name" {
  description = "DNS name of the ELB"
  value       = aws_elb.web_elb.dns_name
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.web_asg.name
}

output "instance_ids" {
  description = "EC2 Instance IDs"
  value       = aws_instance.web_instance.*.id
}
