# Automeet Jitsi Meet

This repository contains scripts and configurations for setting up a Dockerized instance of Jitsi Meet on a fresh Ubuntu server, including NGINX proxy configuration with SSL using Certbot.

## Prerequisites

Before running the setup scripts, ensure you have the following prerequisites installed on your Ubuntu server:

- Docker
- Docker Compose

## Getting Started

Follow these steps to set up your Dockerized Jitsi Meet instance:

    1. Change any variables in env-example, specially:

    # Domain name for the Jitsi Meet instance
    DOMAIN_NAME=t6.velaconference.business

    # Email address for administrative purposes
    ADMIN_EMAIL=admin@t6.velaconference.business


    2. Run `sh setup-ubuntu-server.sh`


    3. Visit your domain ex(https://t6.velaconference.business) from any browser
