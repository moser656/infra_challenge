resource "aws_key_pair" "web_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "web_instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.web_key.key_name
  subnet_id     = var.subnet_id

  tags = {
    Name = "WebServer-${count.index}"
  }

  user_data = file("scripts/install_nginx.sh")

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "echo Instance ${self.id} created!"
  }
}
