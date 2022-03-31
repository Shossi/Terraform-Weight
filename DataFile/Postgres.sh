#!/bin/bash
# This script will run on vm creation and create a postgresql env using a dockerfile.
sudo apt update -y
sudo apt install -y docker.io
sudo systemctl enable docker
sudo docker run -d --name measurements --restart always -p 5432:5432 -e 'POSTGRES_PASSWORD=p@ssw0rd42' postgres
# << Change the password << This is an example passowrd