#!/bin/bash

# Path to the website files
website_dir="/path/to/website"

# Web server directory
web_server_dir="/var/www/html"

# Clean the web server directory
rm -rf "$web_server_dir"/*

# Copy website files to the web server directory
cp -r "$website_dir"/* "$web_server_dir"

# Restart the web server (replace with appropriate command for your server)
service apache2 restart

echo "Website deployed successfully!"