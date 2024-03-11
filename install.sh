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

# Stage 1: Setting up and running Suhail Meet services

# Clone the docker-suhail-meet repository
git clone git@github.com:suhailorg/docker-suhail-meet.git

# Move into the docker-suhail-meet repository
cd docker-suhail-meet || exit

# Copy env.example to .env (no loading or validation here)
cp env.example .env

# Set PUBLIC_URL in .env (coming from the Stage 1 .env file)
sed -i "s/#PUBLIC_URL=https:\/\/meet.example.com/PUBLIC_URL=https:\/\/$DOMAIN_NAME/" .env

# Run ./gen-passwords.sh
chmod +x ./gen-passwords.sh
./gen-passwords.sh

# Create required CONFIG directories
mkdir -p ~/.suhail-meet-cfg/{web,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}

# Start services using Docker Compose for Suhail Meet
docker-compose up -d

# Move back to the parent directory
cd ../ || exit

# Stage 2: Running (nginx)

# Run nginx using Docker Compose with build option
docker-compose build --no-cache
docker-compose up -d

docker exec suhail-nginx /bin/bash -c "/scripts/update_ssl_config.sh"
