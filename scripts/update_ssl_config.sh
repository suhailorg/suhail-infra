#!/bin/bash

# Retry interval in seconds
RETRY_INTERVAL=5

# Loop indefinitely until SSL certificate files exist
while true; do
    # Check if SSL certificate files exist
    if [ -f "/etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem" ] && [ -f "/etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem" ]; then
        echo "SSL certificate files found. Updating nginx configuration..."

        # Take a backup of the current nginx.conf
        cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

        # Copy nginx.actual.conf to nginx.conf
        cp /etc/nginx/nginx.actual.conf /etc/nginx/nginx.conf

        echo "Nginx configuration updated successfully."

        # Test the Nginx configuration
        nginx -t

        # Reload Nginx to apply changes
        nginx -s reload

        echo "Nginx reloaded successfully."
        
        # Exit the loop
        break
    fi

    # Display retry message
    echo "SSL certificate files not found. Retrying in $RETRY_INTERVAL seconds..."

    # Wait for the retry interval
    sleep $RETRY_INTERVAL
done
