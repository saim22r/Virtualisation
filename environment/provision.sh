#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
systemctl status nginx


curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt-get install python-software-properties -y
sudo npm install pm2 -g
sudo echo 'export DB_HOST=mongodb' >> .profile

