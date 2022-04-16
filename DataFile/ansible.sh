#!/bin/bash
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install docker.io -y
mkdir /home/ubuntu/agent
cd /home/ubuntu/agent
wget https://vstsagentpackage.azureedge.net/agent/2.202.0/vsts-agent-linux-x64-2.202.0.tar.gz
tar zxvf ~/agent/vsts-agent-linux-x64-2.202.0.tar.gz