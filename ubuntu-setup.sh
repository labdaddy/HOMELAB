#!/bin/bash

#this script installs:
#snapd
#network manager
#qemu agent
#docker
#cockpit

#update the system
sudo apt update && sudo apt upgrade -y

#install and enable snapd and create linkn to snap path
sudo apt install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

#install & start network manager
sudo snap install network-manager
sudo systemctl start NetworkManager.service

#Set the default locale
echo "Setting default locale..."
locale-gen en_US.UTF-8

#install and configure cockpit on ubuntu server
sudo apt-get install cockpit -y
sudo apt-get install cockpit-podman -y
sudo systemctl start cockpit
sudo systemctl enable cockpit

#install and enable qemu guest agent
sudo apt install qemu-guest-agent
sudo systemctl enable qemu-guest-agent

#install and enable docker engine
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

#make sure you can execute docker commands without typing sudo every damn time
#create the docker group, add user to it and save the changes
sudo groupadd docker 
sudo usermod -aG docker ${USER}
su - ${USER}
newgrp docker 


