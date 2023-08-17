#!/bin/bash

# Path to the Git repository
git_repo="/path/to/your/git/repository"

# Web server directory
web_server_dir="/var/www/html"

# Pull changes from the Git repository
cd "$git_repo"
git pull origin master

# Clean the web server directory
rm -rf "$web_server_dir"/*

# Copy website files to the web server directory
cp -r "$git_repo"/* "$web_server_dir"

# Restart the web server (replace with appropriate command for your server)
service apache2 restart
echo "Website deployed successfully!"