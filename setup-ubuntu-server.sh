#!/bin/bash

# Pre-install Script for Fresh Ubuntu Server

# Step 1: SSH into the Server
# Make sure you have SSH access to the Ubuntu server.

# Step 2: Update Package Lists
sudo apt update -y
sudo apt-get install docker-compose make -y

# Step 3: Install Necessary Packages
sudo apt install -y docker.io git

# Step 4: Start and Enable Docker Service
sudo systemctl start docker
sudo systemctl enable docker

# Step 5: Add User to Docker Group (Optional)
# If you want to avoid using sudo with Docker commands.
sudo usermod -aG docker $USER

# Step 7: Run Your Installation Script
bash install.sh

# Step 8: Verify Installation
# After the installation script completes, verify that your services are up and running as expected.
