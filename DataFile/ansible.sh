#!/bin/bash
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
cd /home/ubuntu
echo "[servers]
      server1 ansible_host=203.0.113.111
      server2 ansible_host=203.0.113.112
      server3 ansible_host=203.0.113.113

      [all:vars]
      ansible_python_interpreter=/usr/bin/python3
      ansible_connection=ssh
      ansible_user=ubuntu
      ansible_ssh_pass=vagrant" >> inv.ini
echo "[defaults]
      host_key_checking = false" >> ansible.cfg