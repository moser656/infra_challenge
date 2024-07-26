provider "aws" {
  region = var.aws_region
}

# Include all resources
module "web_infrastructure" {
  source = "./"
}
