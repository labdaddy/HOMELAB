#### Create a new disk and add it to a virtual machine 
- Shut down the virtual machine in question
- Re locate to the standard disk storage location: `cd /var/lib/libvirt/images`
- Create a new disk with this compound command using elevated priveleges then state the type of storage (qemu-img), then create a disk image, then name the disk, then select the amount of disk space you want to add in M or G:
- `sudo qemu-img create -f raw mynewdisk 1G`
-Another option is to create a qcow disk with: 
- `sudo qemu-img create -f qcow2 mynewdisk 1G`. This option is better for VM's because you can easily use it for snapshots and such.
- Check your work: `ls -lh`. The new disk should be visible
Now we want to attach the disk to the virtual machine
- Check for the name of the current disk so we know what to attach to: `df`
- Now attach the new disk: `virsh attach-disk vm-name /var/lib/libvirt/images/img-name vdb --cache none
Or use: 
- ` virsh attach-disk vm-name \`
- `--source /var/lib/libvirt/images/img-name \`
- `--target vdb \`
- `--persistent`

Example: attach the disk image ‘/var/lib/libvirt/images/mynewdisk‘ as a virtio disk to the VM/domain named ‘ubuntu-box1‘ and update the domain xml file for new disk (type command on the host):
$ sudo virsh attach-disk mynewdisk /var/lib/libvirt/images/ubuntu-box1-vm-disk1-5G vdb --cache none

- Partition the disk from inside the VM using elevated privelege, then the disk you want to partition: `sudo fdisk /dev/vdb` (or whatever the disk name is)
- Then select new partition with: `n`
- Default partition: `p` (for primary)
- Partition number: `1` (or whatever number)
- Then `p` again to print the partition table
- If the name looks good then write the new partition to disk: `w`
- Format the new partition with your filesystem of choice: `sudo mkfs.ext4 /dev/vdb1
- Create a mount directory: `sudo mkdir /disk2/`
- And mount the disk on the guest: `$ sudo mount /dev/vdb1 /disk2/`
- Edit the file /etc/fstab: `$ sudo vi /etc/fstab` to make it official
- And update it as follows so that /dev/vdb1 get mounted across reboot persistently: `/dev/vdb1    /disk2    ext4     defaults    0 0`
- Save and close the file. And there you have it, the guest VM now has an additional virtualized file-based storage device under KVM Linux-based system.
