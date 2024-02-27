FROM nginx:latest

# Install Certbot and its dependencies
RUN apt-get update && apt-get install -y certbot python3-certbot-nginx

ARG DOMAIN_NAME
ENV DOMAIN_NAME=$DOMAIN_NAME


# Create the webroot directory for Certbot
RUN mkdir -p /var/www/certbot/

# Copy nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf.template /etc/nginx/nginx.conf.template
# Automatically substitute the DOMAIN_NAME variable in the nginx configuration file
RUN envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Set up entrypoint script for certificate renewal
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
