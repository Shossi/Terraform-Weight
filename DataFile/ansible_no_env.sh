#!/bin/bash
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install docker.io -y
cd /home/ubuntu
mkdir ansible
cd /home/ubuntu/ansible
echo "[servers]
      server1 ansible_host=10.0.0.4
      server2 ansible_host=10.0.0.5
      # server3 ansible_host=10.0.0.6

      [localhost]
      127.0.0.1

      [servers:vars]
      ansible_python_interpreter=/usr/bin/python3
      ansible_connection=ssh
      ansible_user=ubuntu
      ansible_ssh_pass=vagrant" >> inv.ini
echo "[defaults]
      host_key_checking = false" >> ansible.cfg

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