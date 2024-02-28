#!/bin/bash

# Start Stage 1 (Jitsi Meet) services
cd ./docker-jitsi-meet || exit
docker-compose up -d

cd ../ || exit

# Start Stage 2 (nginx) services
docker-compose up -d --build
docker exec jitsi-nginx /bin/bash -c "/scripts/update_ssl_config.sh"

