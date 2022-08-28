## PROXMOX ENVIRONMENT SETUP
- type `cd /etc/apt/sources.list.d`
- type `nano pve-enterprise.list`
- put a `#` at the beginning of the line to comment the line out
- type `ctrl + O`, press `enter`, type `ctrl + X`, press `enter`
- type `cd`, press `enter`
- type `nano /etc/apt/sources.list`
- use the arrow keys to move to the bottom of the list, skip a line and enter:
-  `# PVE pve-no-subscription repository provided by proxmox.com`
- `# NOT recommended for production use`
- `deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription`
- type `ctrl + O`, press `enter`, type `ctrl + X`, press `enter`
- type `apt update` and `apt -y dist-upgrade`
- when the update process finishes type `reboot`

voila 
