### FILE SHARING ON PROXMOX
This tutorial assumes that a zfs pool has been created and is available for use.

Install debian 11 LXC
- Go node_name in the proxmox interface.
- Click on local storage below the node_name.
- On the right select `CT templates`, and to the right of that, select `Templates`.
- This will display a popup window with a long list of available LXC container templates.
- From the list, select Debian 11 standard and click on `Download` in the bottom right corner of this popup window.
- The template will download a .tar file with the filesystem of a standard Debian system but without the kernel and kernel modules. Those will be inherited from the host. The container has is own networking, permissions etc but no kernel or drivers.
- 
