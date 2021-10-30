## HOMELAB

### Homelab Hardware
Firewall/ Router
- Dell Optiplex Optiplex 3020
- CPU: i5-4570, 4C/4T, 3.3ghz
- MEMORY:16gb ddr3, 1600mhz
- STORAGE: 120gb ssd
- SOFTWARE: pfsense (firewall, router, DNS, DHCP, IPS, VPN, Adblocker)
- ADDITIONAL PACKAGES: UPS monitor, load balancer, forward/ reverse proxy, network monitoring [arping, iperf, nmap]
 
Virtualization Server
- HP ProDesk 600 G3 SFF
- CPU: i7-6700, 4C/8T, 3.4ghz
- MEMORY: 32gb ddr4, 2400mhz
- STORAGE: 500gb ssd, 2tb hdd
- SOFTWARE: VMWare ESXi (plus Vcenter server)

Storage Server
- HP Proliant Microserver Gen8
- CPU: Xeon E3-1220LV2, 2C/4T, 2.3ghz
- MEMORY: 16gb ddr3 ECC, 1600mhz
- STORAGE: 500gb ssd, 4 x 2tb hdd
- SOFTWARE: Proxmox VE

### Homelab Services: 
- [Hypervisor](#hypervisor)
- [Backup Solutions](#backup-solution)
- [Domain Controller](#domain-controller)
- [Network Security and Services](#network-security-and-services)

#### Hypervisor
- VMWare Esxi
- Proxmox VE

#### Backup solution


#### Domain Controller
- Active Directory

#### Network Security && Services

Firewall/ Router (DNS, DHCP)
- Pfsense
- Sophos

IPS (intrusion prevention system)
- Suricata
- Snort
- Splunk

VPM (virtual private network)
- OpenVPN
- IPSec
