#!/bin/bash

# Start Nginx
nginx -g 'daemon off;' &

# Certificate renewal loop
while :
do
    # Sleep for 7 days before attempting renewal
    sleep 604800
    # Attempt certificate renewal
    certbot renew
    # Reload Nginx to apply renewed certificates
    nginx -s reload
done
