#### NEW VM BOILERPLATE

This awesomely helpful boilerplate info is from the dlford.io homelab tutorial found [here.](https://www.dlford.io/pfsense-nat-how-to-home-lab-part-3/) 

Anytime you clone a VM, you should run the following commands to ensure the new system is seen as a unique machine on the network and maintain some entropy for SSH if it is installed (it should also receive a unique MAC address for all network interfaces when you run the clone operation). All of the commands below should be run as the root user, this can be achieved on Ubuntu by preceding each command with sudo, or first running the command sudo -i to start a root session.

These commands are specific to Ubuntu, consult your distribution’s documentation if you are not using Ubuntu. What we are doing is deleting the machine-id from both locations `/etc/ and /var/lib/dbus`, creating a new machine-id in /etc/ and symlinking it to /var/lib/dbus.

`rm -f /var/lib/dbus/machine-id`
`rm -f /etc/machine-id`
`dbus-uuidgen --ensure=/etc/machine-id`
`ln -s /etc/machine-id /var/lib/dbus/`
These commands are only required if SSH is installed, if they fail it is probably not installed and you can safely skip these.

`ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa -y`
`ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa -y`
`ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521 -y`
Note: The newer Ubuntu releases have cloud-init enabled by default which can interfere with host-name changes. In my opinion cloud-init has great potential, but it’s not quite ready for prime-time yet. I recommend running the command sudo touch /etc/cloud/cloud-init.disabled to disable it for the time being.

These commands change the hostname and all references to it, replace ubuntu-18-04-3 with the hostname of your template VM, and nginx with the desired hostname of your new VM.

`sed -i 's/ubuntu-18-04-3/nginx/g' /etc/hosts`
`sed -i 's/ubuntu-18-04-3/nginx/g' /etc/hostname`
`hostnamectl set-hostname nginx`
The VM needs to be rebooted to complete the changes, but let’s hold off for now since we’ll need to reboot after configuring the DHCP reservation in pfSense.
