 #!/bin/bash 

# Large fonts for messaging
sudo apt-get install figlet

figlet "Updating Stuff"

# Import the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

# Create a list file for MongoDB.
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

# Reload local package database.
sudo apt-get update


# Install the MongoDB packages.
figlet "Installing MongodDB"
sudo apt-get install -y mongodb-org

# Replace config to enable external access to MongoDB
sudo sed -i 's/bind_ip = 127.0.0.1/#bind_ip = 127.0.0.1/g' /etc/mongod.conf

# Restart MongodDB
figlet "Starting MongoDB"
sudo service mongod restart


figlet "MongoDB Installed and started!!!" 

