## PROXMOX ENVIRONMENT SETUP
- `cd /etc/apt/sources.list.d`
- `nano pve-enterprise.list`
- put a `#` at the beginning of the line to comment the line out
- `ctrl + O`, press `enter`
- `cd`, press `enter`
- `nano /etc/apt/sources.list`
- use the arrow keys to move to the bottom of the list, skip a line and enter:
-  `# PVE pve-no-subscription repository provided by proxmox.com`
- `# NOT recommended for production use`
- `deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription`
- type `ctrl + O`, press `enter`
- type `apt -y update && apt -y upgrade`, press `enter`
- then type `apt -y dist-upgrade` and press `enter`
- when the update process finishes type `reboot`

voila 
