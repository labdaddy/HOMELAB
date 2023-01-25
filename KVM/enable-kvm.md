### KVM Setup
- qemu-kvm - software that provides hardware emulation for the KVM hypervisor.
- libvirt-daemon-system - configuration files to run the libvirt daemon as a system service.
- libvirt-clients - software for managing virtualization platforms.
- bridge-utils - a set of command-line tools for configuring ethernet bridges.bridge-utils provides a bridge from your network to the virtual machines 
- virtinst - a set of command-line tools for creating virtual machines.
- virt-manager - an easy-to-use GUI interface and supporting command-line utilities for managing virtual machines through libvirt.
- First step is check to make sure the processor supports virtualization. First way to check this: `lscpu | grep Virtualization` Should return something like: VT-x or AMD-V. Second way to check this: `egrep -c '(vmx|svm)' /proc/cpuinfo`. If the system returns 0 there is no onboard support for virtualization. Sorry. Need to buy a newer machine. If system returns 1 or greater you're aces.
- Next update the system. Ubuntu: `sudo apt-get update` or Rhel/ CentOS: `sudo yum update`
- Then install virtualization packages for the operating system you are working with and start creating VM's. 
- See distro specific instructions below.


### Ubuntu based systems: 
##### For Ubuntu 10.04 - 18.04: `sudo apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils virt-manager virtinst cpu-checker virt-viewer`
##### For newer Ubuntu systems like 20. Use: `sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager`
- Check KVM readiness: `sudo virt-host-validate`. 
- Can also check with" `lsmod | grep kvm`
- Add user to libvirt groups: `cat /etc/group | grep libvirt | awk -F':' {'print $1'} | xargs -n1 sudo adduser $USER`
- THIS IS VERY IMPORTANT. If you forget to do this on Ubuntu you will get an error of: ERROR unsupported configuration: CPU mode 'custom' for x86_64 kvm domain on x86_64 host is not supported by hypervisor. And troubleshooting this will be a pain. Do this with: `sudo adduser $USER kvm` 
- Login again and check group membership: `exec su -l $USER` then type: `id | grep libvirt`
- If that fails try: `exec su -l $USER`
- Start of libvirtd (the virtualization api, see README for this repo): `sudo service libvirtd start`
- Enable libvirtd (if needed): `sudo update-rc.d libvirtd enable`
- Check status of libvirtd: `service libvirtd status`
- KVM automatically creates a virtual switch that the VM's are connected to. The host interface on the switch is virbr0. The interface should be visible from the host machine using: ip addr show virbr0
- Check network: `ip addr show virbr0`. This should show something like: `4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000 link/ether 52:54:00:32:7e:07 brd ff:ff:ff:ff:ff:ff inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0 valid_lft forever preferred_lft forever`. Not exactly this but something similar.
- List any VM's currently running on the machine: `virsh list --all`. Should show no running machines right now.
- CREATING A NEW VM: `virt-install --name {os name} --memory {amount in Mib, 1024} --vcpus 1 --disk size=5 --os-variant {os} --cdrom {iso location}`
- NOTE for the os-variant field. KVM requires super specific naming for the os-variant. There is a list of oses that are recognized as valid names. View this list with: `osinfo-query os`. The resulting list is all the os names you can use in this field.
- STARTING A VM: `virsh start {vm name}`

#### For RHEL 7/ CentOS 7: 
- `sudo yum -y install epel-release` then;
- `sudo yum -y install libvirt qemu-kvm virt-install virt-top libguestfs-tools bridge-utils` then;
- Confirm the kernel modules are loaded: `sudo lsmod | grep kvm`
- Start and enable libvirtd service: `sudo systemctl start libvirtd` then `sudo systemctl enable libvirtd`

#### For RHEL 8/ CentOS 8: 
- `sudo yum -y install epel-release` then;
- `sudo yum -y module install virt` then;
- `sudo yum -y install virt-install virt-viewer virt-top libguestfs-tools` then;
- Confirm the kernel modules are loaded: `sudo lsmod | grep kvm`
- Start and enable libvirtd service: `sudo systemctl start libvirtd` then `sudo systemctl enable libvirtd`


#### EITHER SYSTEM
- To install the optional GUI front end `sudo virt-manager`
- Make sure all is well: `virt-host-validate`
- Enable the libvirt service with: `systemctl enable --now libvirtd`
- There will be no response from the system
- Start the libvirt service with: `systemctl start libvirtd`  
- Again, there will be no response from the system
- Trust but verify. Make sure KVM is loaded: `lsmod | grep kvm`
- This should return something with KVM in it. AMD, VTX, something similar but it will include KVM.
- (possibly, this needs verification) In the case of using a minimal installation you will need the x-window package because virt-manager wont start: `yum install "@X Window System" xorg-x11-xauth xorg-x11-fonts-* xorg-x11-utils -y`
- Also, if you are trying to install a normal GUI version of a disto in a VM and you end up with the minimal version somehow you can always add the gnome desktop after the fact. See here.
- If you want to use the GUI front end to manage VM's start virt-manager with: `virt-manager`. The virtual machine manager GUI window will pop up on the screen.
- Voila!
#### NETWORK BRIDGE
- Use the nmcli network management command line tool to create a Linux bridge on a desired interface. Let’s list available connections.
- sudo nmcli connection show
