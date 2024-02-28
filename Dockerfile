FROM nginx:latest

ARG DOMAIN_NAME
ENV DOMAIN_NAME=$DOMAIN_NAME

# Copy nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY nginx.initial.conf.template /etc/nginx/nginx.initial.conf.template

# Automatically substitute the DOMAIN_NAME variable in the nginx configuration file
RUN envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.actual.conf
RUN envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.initial.conf.template > /etc/nginx/nginx.conf

# Copy scripts
COPY ./scripts/update_ssl_config.sh /scripts/update_ssl_config.sh
RUN chmod +x /scripts/update_ssl_config.sh

# Expose ports
EXPOSE 80
EXPOSE 443
