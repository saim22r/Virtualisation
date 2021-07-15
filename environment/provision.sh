#!/bin/bash

# Automated installation of nginx when using vagrant up
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl restart nginx

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
# sudo apt-get install -y npm
sudo apt-get install python-software-properties -y
sudo npm install -g pm2

cd app/
# sudo npm install -y
