#!/bin/bash

# Update mongodb package
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y # Update package list
sudo apt-get upgrade -y # Find new versions of packages
# Install mongodb
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

cd /etc # Change paths to /etc to change
sudo rm -rf mongod.conf # Deletes the mongod.conf file
# Rewrite the mongod.conf file
sudo echo "
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
net:
  port: 27017
  bindIp: 192.168.10.150
" >> mongod.conf


sudo systemctl restart mongod # Restart mongod
sudo systemctl enable mongod # Enable and activate mongod
