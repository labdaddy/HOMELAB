## FILE SHARING ON PROXMOX
This tutorial assumes that a zfs pool has been created and is available for use.

### Install Debian 11 LXC Container
- Go to node_name in the proxmox interface.
- Click on local storage below the node_name.
- On the right select `CT templates`, and to the right of that, select `Templates`.
- This will display a popup window with a long list of available LXC container templates.
- From the list, select Debian 11 standard and click on `Download` in the bottom right corner of this popup window.
- The template will download a .tar file with the filesystem of a standard Debian system but without the kernel and kernel modules. Those will be inherited from the host. The container has is own networking, permissions etc but no kernel or drivers.
- Next go to create CT (in the upper right corner)
- On the container configuration page leave `unpriveleged container` checked.
- Provide a hostname, password and ssh key (if you want)
- On the next page select the container template from the Template dropdown menu
- On the next page assign a small amount of storage for the OS (8gb is fine)
- On the next page assign CPU (1 core is fine)
- On the next page assign RAM (1 gb is fine)
- On the next page assign an interface, bridge (if using bridges) and IP address
- On the next page assign DNS (optional)
- On the next page click confirm
- Once the container is created start it up.

### Install Cockpit web GUI
- Go to the command line in the container and enter: `nano /etc/apt/sources.list
- At the bottom of the page add: `deb http://deb.debian.org/debian bullseye-backports main contrib` and save
- Then: `apt update && apt full-upgrade`
- Then: `apt install -t bullseye-backports cockpit --no-install-recommends`
- Then: `nano /etc/cockpit/disallowed-users`. 
- Then remove the entry for `root` and save
- Then in the browser go to the server address: ip.add.re.ss::9090 and login

### Install Cockpit-Filesharing
- Go to the github page: [45 Drives Cockpit Filesharing](https://github.com/45Drives/cockpit-file-sharing)
- Go to the Releases section on the right side of the page and copy the link for the latest release (will be a .deb file)
- Go back to the command line in the container and paste in the link (wget http://link.link.etc).
- The package will be downloaded

### Install Cockpit-Navigator
- Go to the github page: [45 Drives Cockpit Navigator](https://github.com/45Drives/cockpit-navigator)
- Go to the Releases section on the right side of the page and copy the link for the latest release (will be a .deb file)
- Go back to the command line in the container and paste in the link (wget http://link.link.etc).
- The package will be downloaded

### Install Cockpit-Identies
- Go to the github page: [45 Drives Cockpit Identities](https://github.com/45Drives/cockpit-identities)
- Go to the Releases section on the right side of the page and copy the link for the latest release (will be a .deb file)
- Go back to the command line in the container and paste in the link (wget http://link.link.etc).
- The package will be downloaded

After this there will be an entry that looks a bit like an error. `Download is performed unsandboxed as root as file xyz.abc couldn't be accessed by user apt etc etc.` This is because apt performed the install but the file is owned by root. To fix enter: `ls' to show the files in the current directory which should be all three cockpit packages. Then enter `rm * .deb to delete these three files. 
Enter `ls` again and there should be no cockpit packages.

Go back to the cockpit GUI in the browser, refresh the page and now the new modules will be visible in the services on the left side.

Next click on file sharing on the left. There will be a notice asking to fix Samba misconfiguration. Click `fix now` and it will be done.

### Add Storage to the Container to Export as SMB Shares
- Go to the container you created, click on `Resources` and then in the `Add` drop down menu click on `Mount Point`.
- In the popup for the mount point configuration select the storage pool and then enter the path: `/mnt/slowdrive` or similar
- In the `Disk Size` section enter a quota, which is the maximum size of this storage. 
- Add more mount points if needed
- Now the container has access to an amount of storage equal to what you just configured above. This can be exported to other machines on the network as SMB shares.

### Create User Groups
- In the Cockpit GUI (in the browser) go to `Identities` on the left and then on the right (main) part of the screen click on `Groups`
- Click on the plus sign, fill in the group name of your choice, click on `create` and the group will be created
- Now go to `Identities` again on the left and click `Users`. Click on 'New Users.` Fill out the relevant fields for your user. Make sure `login shell` is set to `/bin/bash`.  
