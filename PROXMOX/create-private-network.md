### Configure VM Network
Before we set up the VM, we will need a private internal network on the Proxmox host. Head to Datacenter > (Name of your host) > Network, and click Create > Linux Bridge.
You must restart the Proxmox host before you continue so the new network will be available for pfSense to use.
