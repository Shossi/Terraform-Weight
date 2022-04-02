#!/bin/bash
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install docker.io -y
git clone https://github.com/Shossi/bootcamp-app /home/ubuntu/bootcamp-app
cd /home/ubuntu/bootcamp-app
sudo touch .env
sudo chmod 777 .env
echo "# Host configuration
PORT=8080
HOST=0.0.0.0
# Postgres configuration
PGHOST=#
PGUSERNAME=#
PGDATABASE=postgres
PGPASSWORD=#
PGPORT=5432

HOST_URL=#
COOKIE_ENCRYPT_PWD=#
NODE_ENV=development

# Okta configuration
OKTA_ORG_URL=#
OKTA_CLIENT_ID=#
OKTA_CLIENT_SECRET=#" >>.env
sudo chmod 644 .env