#### How to add drives to proxmox using [this article.](https://manjaro.site/how-to-add-extra-hard-drives-to-proxmox-6-2-ve/)
(in this case cheap old 2.5" laptop hdd's connected to a mini pc via usb to sata adaptor cable)

#### Mount a new drive in Proxmox (for example, to store your log files or ISO images)
Connect/ install the new drive. 
Identify the new drive
- `lsblk`
- New drive will be at the bottom
- Install parted
- `apt install parted`
- Create a new GPT partition
- `parted /dev/sda mklabel gpt`
- Make a new primary partition with Ext4 filesystem and use 100% of the disk.
- `parted -a opt /dev/sda mkpart primary ext4 0% 100%`
- Check the new layout
- `lsblk`
- Create a new ext4 filesystem
- `mkfs.ext4 -L storage2 /dev/sda1`
- Make a new storage directory to represent the new drive
- `mkdir -p /mnt/storage2`
- Modify the /etc/fstab so it will be mounted automatically upon system boots.
- `nano /etc/fstab`
- Add the following line in the fstab file
- `LABEL=storage2 /mnt/storage2 ext4 defaults 0 2`
- Now mount the drive.
- `mount -a`
- Now check with lsblk command again
- `lsblk`
- Now the new formatted drive is visible
- Prepare the disk to store the VM backups. We will create a special folder for this purpose.
- `mkdir /mnt/storage2/vm_backup`
- Prepare the disk for Proxmox backups
- Navigate to `Datacenter >> Storage >> Add >> Directory`. Enter the required information there.
- Click `add` and you're done
