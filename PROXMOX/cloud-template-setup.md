## Credit where its due: I used the commands and outline provided in this tutorial, [Creating a VM template in Proxmox](https://tcude.net/creating-a-vm-template-in-proxmox/)

# CLOUD TEMPLATE SETUP
1. Start by creating a vm.
2. As you go through the tabs, on the OS tab select type Linux and select the do not use any media options.
3. On the disks page click the trash can icon to remove the attached disk
4. Continue through the remaining tabs and complete the vm creation. DO NOT START THE VM YET
5. The VM should now show up in the left hand panel with the rest of your VM inventory. Select it and navigate to the "Hardware" tab
6. Here we will add a Cloudinit Drive
7. Select the name of the storage pool you would like to use
8. Next, navigate to the "Cloud-Init" tab for the template.  Here you will be able to configure some of the default settings for the template that take advantage of cloud-init's capabilities
9. Add a default user to be created when a new VM is spun up. You can populate this field with whatever you'd like your default user to be named
10. With your username defined, you will also want to configure a password for your account.  It is important to ensure this is spelled correctly.
11. For network, configure the template to use DHCP or whatever network setup you choose. 
12. Now all settings are configured for Cloud-init.
13. At this point, you will now need to do a bit of work in the command line. Access your proxmox shell either directly or through SSH.
14. To start, you will need to download the cloud image of your chosen OS from the online repo. In my case it will Ubuntu 22 server, available with many options here: https://cloud-images.ubuntu.com/releases/jammy/release/?ref=tcude.net. Choose from the options on that page, right click your selection and choose 'copy link address'. 
15. Now, go to the proxmox shell and download the cloud version of the OS image of your choice using wget. Save this image to /tmp/os-image-name. In the example below I will use an ubuntu cloud image and save it to /tmp/ubuntu-22.04.
EXAMPLE: `wget https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img -O /tmp/ubuntu-22.04.img`.
16. Now, rename the image to change the file format to .qcow2 (required by Proxmox) using: `mv ubuntu-22.04-server-cloudimg-amd64.img ubuntu-22.04-server.qcow2`
17. This next command is necessary to be run to ensure the Proxmox GUI has console access to the VM.  If not, you will likely not be able to see anything through the console page. `qm set <vm_id> --serial0 socket --vga serial0` 
18. Then import the disk `qm importdisk 999 ubuntu-22.04-server.qcow2 zfs`
19. Modify the previous command to fit your needs: `qm importdisk <vm_id> ubuntu-22.04-server.qcow2 <storage_name>` 
20. After running the command, you should see the change added successfully within the Hardware tab of the VM
21. With the disk selected, you will now need to click Edit in order to add the disk
22. Before adding, enable `SSD emulation`, as well as checking `Discard` to enable thin provisioning
23. Now we can see the previously unused disk is successfully set up to be utilized by the VM/template
24. Next, under the Options tab, you will need to modify the Boot Order
25. As you can see, your new device, shown above as scsi0, is not enabled
26. Enable and move it up to the second boot option

# Adding the QEMU Agent
Now that your template has been set up, the last step before actually converting it to a proper template (which is an irreversible process), is to add the qemu-guest-agent.  You can do this with the following steps:

1. Power up the template/VM you have created
2. Install the agent with `sudo apt update && sudo apt upgrade -y && sudo apt install qemu-guest-agent`
3. Enable the agent with `sudo systemctl enable qemu-guest-agent`
4. Reset the machine-id with `cat /dev/null > /etc/machine-id`
5. Another command to reset the machine-id: `cat /dev/null > /var/lib/dbus/machine-id`
6. Run `cloud-init clean`
7. Finally, run `shutdown -h` now

# Converting to a Template
1. We are now ready to convert our VM to a template! To do so, simply right click the VM and click `Convert to template`
2. You should now be able to see that the icon of what used to be a VM has changed, indicating that it is now a template
3. Creating a new VM is now a breeze.  Right click on the template and select `Clone`
4. Here, you can configure a few options for your VM before cloning it. Give it a name, as well as changing the Mode to Full Clone.
5. You can view the differences between a full clone and a linked clone here: https://pve.proxmox.com/wiki/VM_Templates_and_Clones
6. It is also worth noting that you can change where the VM will be stored using the `Target Storage` drop down menu.
7. After clicking `Clone`, Proxmox will proceed with cloning the template into a new VM.
8. Here we can see the newly created VM based off of the template. Let's power it on! Cloud-init will now do its thing. Give it some time as it sets up the new VM.
9. Once your SSH key has been imported (if relevant to your use case) and `Cloud-init`` stops, you can now log in to your new VM
10. Note that you will likely have to press Enter before seeing the <hostname> login: prompt shown above
