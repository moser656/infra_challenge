#!/bin/bash

# Update and install Nginx
sudo yum update -y
sudo yum install nginx -y

# Start Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Configure Nginx to use self-signed SSL
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/CN=yourdomain.com"

# Nginx config
sudo bash -c 'cat <<EOF > /etc/nginx/conf.d/hello_world.conf
server {
    listen 80;
    server_name _;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name _;

    ssl_certificate /etc/nginx/ssl/nginx-selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx-selfsigned.key;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
EOF'

# Create index.html
sudo bash -c 'echo "<html><head><title>Hello World</title></head><body><h1>Hello World!</h1></body></html>" > /usr/share/nginx/html/index.html'

# Restart Nginx
sudo systemctl restart nginx
