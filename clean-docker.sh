#!/bin/bash

# Stop all running containers
docker stop $(docker ps -q)

# Remove all stopped containers
docker rm $(docker ps -a -q)

# Remove all dangling/untagged images
docker rmi $(docker images -f "dangling=true" -q)

# Remove all networks not used by at least one container
docker network prune -f

# Remove all volumes not used by at least one container
docker volume prune -f

# Uninstall Docker
sudo apt-get purge docker.io docker-compose -y
sudo apt-get autoremove -y
sudo rm -rf /var/lib/docker

# Uninstall Docker Compose
sudo rm /usr/local/bin/docker-compose

echo "Docker and Docker Compose have been successfully removed."
