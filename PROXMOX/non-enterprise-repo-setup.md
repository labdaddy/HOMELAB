## PROXMOX ENVIRONMENT SETUP

After installing proxmox we need to configure updates outside of the paid enterprise repository.
First Login
Then on the left column, click the name you chose for your server during the installation, then click the Shell button on the top right.
A new window should open with a command line on the server. You will need to type in the five commands below to accomplish the following:
Move to the directory where Advanced Package Tool (APT) looks for software update repositories
Rename the Enterprise configuration file to have .disabled at the end so it is ignored by APT
Create a configuration file for the Community repository
Update APT’s package list
Install all available software updates

- type `cd /etc/apt/sources.list.d`
- type `nano pve-enterprise.list`
- put a `#` at the beginning of the line to comment the line out
- type `ctrl + O`, press `enter`, type `ctrl + X`, press `enter`
- type `cd`, press `enter`
- type `nano /etc/apt/sources.list`
- use the arrow keys to move to the bottom of the list, skip a line and enter:
-  `# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription`
- type `ctrl + O`, press `enter`, type `ctrl + X`, press `enter`
- type `apt update` and `apt -y dist-upgrade`
- when the update process finishes type `reboot`

voila 
