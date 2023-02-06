## PROXMOX INSTALLED ON A SINLGLE DRIVE
When installing Proxmox on a device with a single drive, Proxmox will partition off some of the drive making it unusable. The commands below will remove these partitions and make the whole drive available for use.

### Commands for single drive storage:
-----------------
`lvremove /dev/pve/data`
`lvresize -l +100%FREE /dev/pve/root`
`resize2fs /dev/mapper/pve-root`

Voila, the whole drive is available !
