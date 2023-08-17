#!/bin/bash

# Update packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Configure firewall (replace with your firewall management commands)
sudo ufw allow 'Nginx Full'
sudo ufw enable

# Create a basic virtual host configuration
sudo mkdir -p /var/www/example.com
sudo chown -R $USER:$USER /var/www/example.com
sudo chmod -R 755 /var/www/example.com
echo "<html><body><h1>Welcome to Example.com!</h1></body></html>" | sudo tee /var/www/example.com/index.html

sudo tee /etc/nginx/sites-available/example.com <<EOF
server {
    listen 80;
    server_name example.com www.example.com;
    root /var/www/example.com;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Create a symbolic link to enable the virtual host
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/

# Test Nginx configuration and reload
sudo nginx -t
sudo systemctl reload nginx

echo "Web server configuration completed!"
