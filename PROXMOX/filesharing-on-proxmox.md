## FILE SHARING ON PROXMOX
This tutorial assumes that a zfs pool has been created and is available for use.

### Install Debian 11 LXC Container
- Go node_name in the proxmox interface.
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
- Go to the github page: [45 Drives Cockpit Filesharing:](https://github.com/45Drives/cockpit-file-sharing)

### Install Cockpit-Navigator
- Go to the github page: [45 Drives Cockpit Navigator](https://github.com/45Drives/cockpit-navigator)

### Install Cockpit-Identies
- Go to the github page: [45 Drives Cockpit Identities](https://github.com/45Drives/cockpit-identities)
