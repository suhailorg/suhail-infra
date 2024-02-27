#!/bin/bash


# Start Nginx with the initial configuration file
nginx -g 'daemon off;' &

# Certificate renewal loop
while :
do
    # Sleep for 7 days before attempting renewal
    sleep 604800

    # Attempt certificate renewal
    certbot renew --nginx --dry-run

    # Reload Nginx to apply renewed certificates and updated configuration
    nginx -s reload
done
