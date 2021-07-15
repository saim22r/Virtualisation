#!/bin/bash

# Automated installation of nginx when using vagrant up
sudo apt-get update -y # Update package list
sudo apt-get upgrade -y # Find new versions of packages
sudo apt-get install nginx -y # Install nginx
sudo systemctl status nginx # Check nginx status

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - # Update nodeje package
sudo apt-get install -y nodejs # Install nodejs and npm
sudo apt-get install python-software-properties -y # Install python dependencies
sudo npm install -g pm2 # Uses npm to install pm2 package

sudo rm -rf /etc/nginx/sites-available/default

sudo echo "server{
        listen 80;
        server_name _;
        location / {
        proxy_pass http://192.168.10.100:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        }
}" >> /etc/nginx/sites-available/default

sudo systemctl restart nginx
sudo systemctl enable nginx

cd environment/app
node seeds/seed.js
~/.source
npm start

