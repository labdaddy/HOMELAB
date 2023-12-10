#example script (ubuntu)

#first update the system
sudo apt update && sudo apt upgrade -y

#install qemu guest agent (for proxmox)
sudo apt install qemu-guest-agent -y

#enable guest agent on host
sudo systemctl enable qemu-guest-agent

#install cockpit on ubuntu server
apt-get install cockpit -y

#install podman (required)
apt-get install cockpit-podman -y

#start, enable and check status of the cockpit service
systemctl start cockpit
systemctl enable cockpit
systemctl status cockpit

#install cockpit on rocky server
sudo dnf install cockpit -y

#start, enable and check status of the cockpit service
sudo systemctl start cockpit.socket
sudo systemctl enable cockpit.socket
sudo systemctl status cockpit.socket

#install docker
#first remove any conflicting packages:
for pkg in http://docker.io  docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

#then run the convenience script
curl -fsSL https://get.docker.com -o get-docker.sh

#then startup docker engine
sudo sh ./get-docker.sh

#make sure you can execute docker commands without typing sudo every damn time
#create the docker group, add user to it and save the changes
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

#test run docker
docker run hello-world

#reboot system
sudo reboot
