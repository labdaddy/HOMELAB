#### Proxmox first setup
After installation is complete we need to update. We are using the free community version of Proxmox so we need to change the default enterprise software repository to the free community one.
- Click the name of your server
- Then click `shell` over on the right
- Then type all of the following:
- `cd /etc/apt/sources.list.d` and press `enter`
- `mv pve-enterprise.list pve-enterprise.list.disabled` and press `enter`
- `echo 'deb http://download.proxmox.com/debian/pve buster pve-no-subscription' > pve-community.list` and press `enter`
- `apt update` and press `enter`
- `apt -y dist-upgrade` and press `enter`
- Then reboot using the `reboot` button over on the right.
- Once that is done we need to actually do the updates.
- Click on the name of your server again. 
- Then on the list that shows `summary`, `shell`, `system`, `network` etc you want to click on `updates` and then `refresh`.
- After the popup window does its thing and finishes with "OK" close the popup box.
- Next click `upgrade` and another window pops up. Press `y` and then `enter` and then when it also does its thing and finishes you close that window as well.
- Reboot if it tells you to. (use the `reboot` button over on the right)
- Done.

