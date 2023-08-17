#!/bin/bash

# Update packages
sudo apt-get update
sudo apt-get upgrade -y

# Add a new user
sudo adduser newuser

# Add user to sudo group
sudo usermod -aG sudo newuser

# Configure SSH keys for user
sudo mkdir /home/newuser/.ssh
sudo cp /path/to/public_key.pub /home/newuser/.ssh/authorized_keys
sudo chown newuser:newuser -R /home/newuser/.ssh
sudo chmod 700 /home/newuser/.ssh
sudo chmod 600 /home/newuser/.ssh/authorized_keys

# Configure SSH to disallow root login and password authentication
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Configure firewall (replace with your firewall management commands)
sudo ufw allow OpenSSH
sudo ufw enable

# Set up automatic updates (replace with your package manager's method)
sudo apt-get install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades

# Install essential tools
sudo apt-get install -y vim git curl

echo "Initial server configuration completed!"