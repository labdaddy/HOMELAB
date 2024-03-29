## CREATE A MINIMAL UBUNTU SERVER CLOUD IMAGE

- start the VM creation process
- On the General tab: assign a number to the VM, provide a name, click next
- On the OS tab: on ISO image select `Do not use any media`, next
- On the System tab: click the box for `Qemu agent`, next
- On the Disks tab: delete the storage disk displayed in the little box on the left side of the popup window, next
- On the CPU tab: select cores, next
- On the Memory tab: select memory, next
- On the Network tab: choose the network you want and make sure `VirtIO (paravirtualized)` is selected, next
- On the Confirm tab: review, make sure `Start after created` is NOT selected, click `Finish`
- Once the VM is created go to the hardware tab for that new VM and add a `Cloudinit Drive`
- On the popup choose local storage or whatever other storage provider you want to use then click add
- Then go to the Cloud-Init section on the left (the section below Summary, not CloudInit drive attached to the machine) and click it
- On this tab click `User` and enter the name you want
- Then click on `Password` and enter the password you want
- Then on `SSH key`, if you have a public SSH key you would like to use for this machine go ahead and add it here
- Then on `Network`, set to DCHP (or don't, depending on your network needs)
- Then click `Regenerate image`.
- Open the shell on the proxmox host or SSH in and access the shell that way
- Download the ubuntu cloud image using: `wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img`
- Once thats done, you need to run a qm command on the shell: `qm set <VM ID> --serial0 socket --vga serial0`
- For some currently unknown reason, the recently downloaded image needs to be renamed so the file type is qcow2. Use this command: `mv ubuntu-22.04-server-cloudimg-amd64-disk-kvm.img ubuntu-22.04.qcow2` The name could be whatever you want just make sure the extension is changed to qcow2.
- Next the drive size needs to be selected with: `qemu-img resize ubuntu-22.04.qcow2 32G` Use whatever size you want, doesn't need to be 32G .
- Next we need to import the disk to Proxmox with `qm importdisk <vm id > ubuntu-22.04.qcow2 local-lvm`. Local lvm does not need to be used, just replace with whatever storage location you intend to use.
- Next go back to the proxmox GUI and go the hardware tab for the VM
- At the bottom of the list is `Unused disk`, click on it and then click `Edit` at the top
- Then on the popup click the checkbox next to `Discard` to enable thin provisioning
- Then, if you are using an SSD for the storage for this VM, click the checkbox next to `Advanced`
- Make sure to check SSD Emulation then click on the blue `Add` button
- Now on the next screen you can see that the hard disk is populated and in use
- Next click on the Options section (the one below Summary) and then select `Boot order` and click `Edit`
- Then on the `Boot order` popup click and hold the VM disk (will say scsi0 or similar) and drag it to the second position in the list and click `OK`
- Then on the pve view on the main GUI console, right click on the VM you've been working on and click `Convert to template`
- Now, to actually create a VM from this template, right click on the template and then click `Clone`
- In the popup menu assign a different ID, set the `Mode` to `Full clone` and then give the clone a name
- A few seconds later the new VM is created


## Adding the QEMU Agent
Now that your template has been set up, the last step before actually converting it to a proper template (which is an irreversible process), is to add the qemu-guest-agent.  You can do this with the following steps:

1. Power up the template/VM you have created
2. Install the agent with `sudo apt update && sudo apt upgrade -y && sudo apt install qemu-guest-agent`
3. Enable the agent with `sudo systemctl enable qemu-guest-agent`
4. Reset the machine-id with `cat /dev/null > /etc/machine-id`
5. Another command to reset the machine-id: `cat /dev/null > /var/lib/dbus/machine-id`
6. Run `cloud-init clean`
7. Finally, run `shutdown -h now`
