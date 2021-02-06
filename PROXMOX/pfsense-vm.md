### Set up a pfSense VM
Create a new VM, if you check the advanced box at the bottom you will have the option to set up auto-start settings:

- Start at boot: Auto-start this VM when the Proxmox host boots up
- Start/Shutdown order: At boot time, the lower numbered VMs will start up first, and on shutdown/reboot the higher numbered VMs will shut down first. I like to start these in increments of 10 so you can slip new VMs in wherever they should go later, there is also nothing wrong with using the same number for multiple VMs, they will just be started/shut down at the same time.
- startup delay: The number of seconds to wait after booting this VM before booting the next VM.
- Shutdown timeout: The number of seconds to wait during a shutdown of the Proxmox host for this VM to finish shutting down, this prevents the system from hanging if a VM refuses to shut down, I usually leave it blank to use the default setting of 5 minutes.
- You only need to add a comment for this network, all of the IP configuration will be handled by pfSense once we get it running.
- In the OS tab, choose the ISO image for pfSense, and choose “other” for Guest OS.
- Accept the default settings for the System tab, in the Hard Disk tab change the Bus/Device to VirtIO Block.
- Always check the box for discard, this will free up space from files deleted on the VM guest, if unchecked the free space will be available to the VM guest but still marked as used on the Proxmox host and storage device
- Under the CPU tab, set the CPU cores for this VM, 1 should be just fine, and set CPU units to 2048. CPU units give each VM a priority for CPU time, so VMs that are less critical can just use the default value of 1024, and critical VMs should get a higher value so they get priority if there is a high demand for CPU usage.
- For memory, 1024MiB is minimum required otherwsie you will get weird errors after installation. You can always use more if you want. 
- Under the Network tab, choose VirtIO for the Model, and leave the Bridge on vmbr0, we will add the new network after the wizard is finished.
- Finish the setup wizard, then head over to Datacenter > (Name of your host) > pfSense > Hardware > Add > Network Device.
- Choose vmbr1 for the bridge (our internal private network), and VirtIO for the model.
- Then install pfsense: Click the start button in the top menu bar, and then click the console tab on the left to run through the installer for pfSense, the default install options should be fine.

### Configure pfSense
- After the bootup is finished, choose option 8 and press enter to open a shell session.
- We need to disable the packet filter (firewall) temporarily so we can access the web interface from the WAN side which is disabled by default, use the command pfctl -d to accomplish this, and note the IP Address of the WAN interface shown above the menu options, you’ll need it in the next step.
Note: You may get locked out a few times during the setup before we add a rule to allow the traffic, because changing certain settings will reload the packet filter and thus turn it back on, just go back to the console on Proxmox and run the pfctl -d command again. Disabling the packet filter will be required over and over again. Get used to it.
- From a web browser, visit https://(IP address of pfSense), you’ll be greeted with the invalid SSL Certificate page, choose Advanced > Accept the risk and continue, or proceed to the website depending on which browser you are using. 
- Then log in with the default credentials: Username: admin Password: pfsense
- Click through the first couple of pages, then choose a hostname, domain, and DNS servers. You can use the same domain as your Proxmox host or a new one, and any public DNS servers you wish.
- The default time server is just fine, make sure you get your timezone correct though.
- Configure the WAN interface with a static IP address within your home network subnet but outside of the DHCP range just like your Proxmox host, match the subnet mask and upstream gateway to your home network settings and click next at the bottom of the page.
- Next, configure the LAN IP address and subnet mask for pfSense, this is for the private internal network side, so it should be a new private network range that doesn’t already exist within your home network. If your home network is 192.168.0.xx then use 10.0.0.xx or 172.16.0.xx 
- For reference the private IP address ranges are: 
`10.0.0.0/8 IP addresses: 10.0.0.0 – 10.255.255.255`
`172.16.0.0/12 IP addresses: 172.16.0.0 – 172.31.255.255`
`192.168.0.0/16 IP addresses: 192.168.0.0 – 192.168.255.255`
- Let’s first set up an alias for the administration ports that pfSense uses, this way we can assign a rule to all of the ports at once instead of making a new rule for each port, we’re adding port 8080 to this alias because we’re going to move the admin interface to that port so we can free up ports 80 and 443 for regular web traffic behind NAT.
- Head to Firewall > Aliases > Ports > Add
- You can change the name and description values here to your taste, you can even leave the description for each port blank, just remember the name of the alias because we’ll be using it soon.
- Now head to Firewall > Rules > WAN > Add
Note: Firewall rules in pfSense are applied to traffic going IN to the interface they are configured on, they do not apply to traffic going OUT of that interface, so just keep that in mind. In our use case, the WAN interface is your home network, and the LAN interface is your private server network that will only be accessible from VMs or through the pfSense firewall.
- We want to add a rule to allow access from your home network to the admin interface of the pfSense firewall, here are the settings we need to accomplish that goal:

Action: Pass
Disabled: Unchecked
Interface: WAN
Address Family: IPv4
Protocol: TCP
Source
Network: Where the allowed traffic will come from, this should be your home network.
Destination
Destination: This firewall (self)
Destination Port Range
From: pfSense_Admin_Ports (the alias we created earlier)
To: pfSense_Admin_Ports (the alias we created earlier)
Extra Options
Description: This is just to help you identify rules, it’s helpful when you have a long list of rules on an interface
- For the remainder of this article, when you see this message after changing something just go ahead and click Apply Changes, it is displayed because there are some cases where you may need to change several settings before applying so all the changes get applied at once, but we aren’t doing anything like that today.
- Next, go to Interfaces > WAN, and uncheck the two boxes at the bottom for “Block private networks and loopback addresses”, and “Block bogon networks”, save and apply (We want to allow our local private network to access the WAN interface).

You should now be able to turn the packet filter back on and still access the admin page for pfSense, so back in your console session on Proxmox, run the command pfctl -e to enable the firewall again.

Let’s get rid of this warning about changing the password really quick, go ahead and click “Change the password…”
- You know the drill, enter a new password twice and click save at the bottom of the page.

pfSense recommends disabling the large receive offload (LRO) setting when it’s running on a VM (if the admin interface feels slow, this should help that too), head to System > Advanced > Networking, check the box “Disable hardware large receive offload”, and click save.
- As I mentioned, we need to move the admin interface to port 8080, head to System > Advanced > Admin Access.
- Change the value “TCP Port” under “webConfigurator” to 8080, and click save at the bottom of the page. It should redirect you to the new port automatically after a short delay for the configuration to be applied. If it doesn’t just manually type in the URL bar of your browser https://(IP address):8080.



