variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
}

variable "public_key_path" {
  description = "Path to the public key"
  default     = "~/.ssh/your_key.pub" # path to your SSH key
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
}

variable "subnet_id" {
  description = "Subnet ID where resources will be deployed"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI ID, change based on region
}

variable "instance_count" {
  description = "Number of EC2 instances"
  default     = 2
}
