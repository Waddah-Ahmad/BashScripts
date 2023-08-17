#!/bin/bash

# Stop web server (replace with appropriate command for your server)
service nginx stop

# Renew SSL certificate using Certbot
certbot renew

# Start web server (replace with appropriate command for your server)
service nginx start

# Check if certificate renewal was successful
if [ $? -eq 0 ]; then
    echo "SSL certificate renewed successfully"
else
    echo "SSL certificate renewal failed"
fi