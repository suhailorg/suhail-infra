#!/bin/bash

# Start Stage 1 (nginx) services
docker-compose up -d --build

# Start Stage 2 (Jitsi Meet) services
cd ./docker-jitsi-meet || exit
docker-compose up -d

cd ../ || exit
