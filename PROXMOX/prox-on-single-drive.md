## PROXMOX INSTALLED ON A SINLGLE DRIVE
When installing Proxmox on a device with a single drive, Proxmox will partition off some of the drive making it unusable. The commands below will remove these partitions and make the whole drive available for use.


### Commands for single drive storage:
First go to the datacenter view and then click on storage.
In the storage list click on the storage pool with the name: local-lvm.
Click `remove`. 
Then go to the shell and enter the commands below:

-----------------
- `lvremove /dev/pve/data`
- `lvresize -l +100%FREE /dev/pve/root`
- `resize2fs /dev/mapper/pve-root`

Voila, the whole drive is available !
