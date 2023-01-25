#### Virsh Commands
In the parlance of virsh commands a virtual machine is called a domain.
- List all domains: `virsh list --all`
- List running domains only: `virsh list`
- Start a domain: `virsh start centos7` 
- Verify the domain actually started running: `virsh list`
- Gracefully shutdown a running domain: `virsh shutdown centos7`
- Force stop a frozen, unresponsive domain: `virsh destroy centos7`. NOTE: this does not actually destroy anything, it just pulls the plug on the domain shutting it down immediately
- Reboot a domain: `virsh reboot centos7`
- Get info about a domain: `virsh dominfo centos7`
- Have a domain startup when the host machine boots up: `virsh autostart centos7`
- Turn off this autostart setup: `virsh autostart --disable centos7`
- Bash script to shutdown all running domains at once: `for i in `sudo virsh list | grep running | awk '{print $2}'` do
    sudo virsh shutdown $i
done`
- To cleanly remove a vm including its storage columes:
- `$ sudo virsh destroy centos7 2> /dev/null`
- `$ sudo virsh undefine centos7`
- `$ sudo virsh pool-refresh default`
- `$ sudo virsh vol-delete --pool default centos7.qcow2`
