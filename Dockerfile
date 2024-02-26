FROM nginx:latest

# Copy nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy SSL certificate files
COPY fullchain.pem /etc/ssl/certs/fullchain.pem
COPY privkey.pem /etc/ssl/certs/privkey.pem
COPY options-ssl-nginx.conf /etc/letsencrypt/options-ssl-nginx.conf
COPY ssl-dhparams.pem /etc/letsencrypt/ssl-dhparams.pem
