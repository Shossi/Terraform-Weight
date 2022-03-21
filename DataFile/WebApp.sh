#!/bin/bash
sudo apt update
sudo apt install docker.io -y1
sudo systemctl enable docker
sudo docker run -d --restart always -p 8080:8080 joeyhd/weight:1.1
