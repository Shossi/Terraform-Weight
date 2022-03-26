#!/bin/bash
sudo apt update
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt -y install nodejs
git clone https://github.com/Shossi/bootcamp-app /home/ubuntu/bootcamp-app
cd /home/ubuntu/bootcamp-app
sudo npm install
sudo npm init -y
sudo touch .env
sudo chmod 777 .env
echo ### >>.env
sudo chmod 644 .env

sudo npm install -g pm2
#You need to run these commands after changing the HOST_URL to the lb public ip.
#npm run initdb
#pm2 start "npm run dev"
#pm2 startup
#sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
#pm2 save