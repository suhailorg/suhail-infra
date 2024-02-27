#!/bin/bash

# Perform environment variable substitution in nginx configuration
envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# # Function to check if all SSL certificate files exist
# check_certificates() {
#     echo "Checking for SSL certificate files..."
#     while [ ! -f "/etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem" ] || \
#         [ ! -f "/etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem" ]; do
#         echo "SSL certificate files not found. Waiting..."
#         ls -l /etc/letsencrypt/live/${DOMAIN_NAME}/  # Debug: List files in directory
#         ls -l /etc/letsencrypt/  # Debug: List files in directory
#         sleep 10
#     done
#     echo "All SSL certificate files found."
# }

# # Check if SSL certificates are obtained before starting Nginx
# check_certificates

# Start Nginx
echo "Starting Nginx..."
nginx -g 'daemon off;'
