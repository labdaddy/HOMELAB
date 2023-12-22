## Credit where its due: I used the commands and outline provided in this tutorial, [How to create a Proxmox VM template](https://4sysops.com/archives/how-to-create-a-proxmox-vm-template/)
1. Start by creating a vm. 
2. As you go through the tabs, on the OS tab select type `Linux` and select the `do not use any media` options.
3. On the disks page click the trash can icon to remove the attached disk
4. Continue through the remaining tabs and complete the vm creation. DO NOT START THE VM YET
5. Go to the proxmox shell and download the cloud version of the OS image of your choice. Save this image to `/tmp/os-image-name`. In the example below I will use an ubuntu cloud image and save it to `/tmp/ubuntu-22.04`
6. `wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img -O /tmp/ubuntu-22.04.img`
7. 
