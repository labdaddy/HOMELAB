Upon logging in, you will be presented with a “You do not have a valid subscription” warning, this will always pop up when you log in and that’s fine, we aren’t going to use the Enterprise Edition, we will use the free Community Edition, there are a few steps to get that set up.

On the left column, click the name you chose for your server during the installation, then click the Shell button on the top right.

A new window should open with a command line on the server. You will need to type in the five commands below to accomplish the following:

1. Move to the directory where Advanced Package Tool (APT) looks for software update repositories
2. Rename the Enterprise configuration file to have .disabled at the end so it is ignored by APT
3. 3. Create a configuration file for the Community repository
4. Update APT’s package list
5. Install all available software updates
    
`cd /etc/apt/sources.list.d`
`mv pve-enterprise.list pve-enterprise.list.disabled`
`echo 'deb http://download.proxmox.com/debian/pve buster pve-no-subscription' > pve-community.list`
`apt update`
`apt -y dist-upgrade`

You’ll want to reboot after installing the updates by clicking the reboot button on the web interface, feel free to choose shutdown here if you want to move the server computer somewhere else now that it’s all set up.
    
