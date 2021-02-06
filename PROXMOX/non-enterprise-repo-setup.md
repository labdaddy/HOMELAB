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

- `cd /etc/apt/sources.list.d`
- `mv pve-enterprise.list pve-enterprise.list.disabled`
- `echo 'deb http://download.proxmox.com/debian/pve buster pve-no-subscription' > pve-community.list`
- `apt update`
- `apt -y dist-upgrade`

Then reboot the server using the reboot button.
