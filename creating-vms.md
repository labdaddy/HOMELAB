#### Setup Virtual Machines In KVM
- virt-install --name {somenamehere}
- --memory {in MiB, like 2048}
- --vcpus {recommend only 1}
- --disk size= {no space between the = and the value, value is in GiB, like 80}
- -os-variant {windows10 or rhel8}
- --cdrom {for isos} {and then location such as} /home/username/Downloads/rhel8-iso

#### Sample Setup Values: 
- `sudo virt-install --name server1 --memory 2048 --vcpus 1 --disk size=20 --os-variant centos8 --cdrom /home/primero/Documents/iso/CentOS-8.2.2004-x86_64-minimal.iso`
- `sudo virt-install --name ubuntuserver --ram 2048 --vcpus 1 --disk size=20 --cdrom /home/primero/Documents/iso/ubuntu-18.04.3-server-amd64.iso --os-variant ubuntu18.04 --os-type linux`
##### NOTE: If you keep getting permission errors on the file path try shutting down the machine. Sometimes after restarting this command will suddenly work fine.
In Ubuntu 20, another issue could be that AppArmor is getting in the way. If you are getting errors like "failed to connect" or "not connected to KVM/ QEMU" or something similar, its probably AppArmor. The content below is from the following source: [Kifarunix](https://kifarunix.com/how-to-fix-qemu-kvm-not-connected-error-on-ubuntu-20-04/)

To do some checking: `id -nG` will make sure that you are part of the libvirt group.

Then: `lsmod | grep kvm` will make sure necessary kernel modules are loaded. This will probably list a bunch of issues with libvirt.

Next check for libvirt issues in the logs with: `sudo grep libvirt /var/log/syslog | grep -i apparmor | grep -i denied`

And an additional check in the kernel ring buffer with: `dmesg| grep -i libvirt`. This will probably show a bunch of issues with AppArmor trying to "protect" you from libvirt.

Then a check in AppArmor: `sudo aa-status`

Check AppArmor's libvirtd profile: `cat /etc/apparmor.d/usr.sbin.libvirtd`

And other files can be checked in: `/etc/apparmor.d/libvirt/ and /etc/apparmor.d/abstractions/`.

##### Disabling AppArmor enforement for libvirt
`sudo ln -s /etc/apparmor.d/usr.sbin.libvirtd /etc/apparmor.d/disable/`

`systemctl reboot -i`

And now all should be well.


### Running VM's In KVM
- using the `virsh start` utility: `virsh start` {vmname}
- Example: `virsh start rhel8iso`

### Checking Available VM's
- sudo `virsh list`

#### NOTE: for os-variant: KVM requires SUPER SPECIFIC naming for the os-variant. There is a list of oses that are recognized as valid names. View this list with: `osinfo-query os`. The resulting list is all the os names you can use in this field. Keep scrolling until you see your os name, then copy it with `ctrl+shift+c` and paste with `ctrl+shift+v`.
