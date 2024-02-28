#!/bin/bash

# Load environment variables from env-example to .env
cp env-example .env

# Load environment variables from .env file
source .env

# Check if required variables are set
if [ -z "$DOMAIN_NAME" ] || [ -z "$ADMIN_EMAIL" ]; then
    echo "Error: DOMAIN_NAME or ADMIN_EMAIL variable is not set in .env file."
    exit 1
fi

# Stage 1: Setting up and running Jitsi Meet services

# Clone the docker-jitsi-meet repository
git clone https://github.com/jitsi/docker-jitsi-meet

# Move into the docker-jitsi-meet repository
cd docker-jitsi-meet || exit

# Copy env.example to .env (no loading or validation here)
cp env.example .env

# Set PUBLIC_URL in .env (coming from the Stage 1 .env file)
sed -i "s/#PUBLIC_URL=https:\/\/meet.example.com/PUBLIC_URL=https:\/\/$DOMAIN_NAME/" .env

# Run ./gen-passwords.sh
chmod +x ./gen-passwords.sh
./gen-passwords.sh

# Create required CONFIG directories
mkdir -p ~/.jitsi-meet-cfg/{web,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}

# Start services using Docker Compose for Jitsi Meet
docker-compose up -d

# Move back to the parent directory
cd ../ || exit

# Stage 2: Running (nginx)

# Run nginx using Docker Compose with build option
docker-compose build --no-cache
docker-compose up -d

docker exec jitsi-nginx /bin/bash -c "/scripts/update_ssl_config.sh"
