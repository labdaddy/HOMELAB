## Homelab Hardware


#### Firewall/ Router
- HP T620 plus
- CPU: AMD GX-420CA APU, 4c/4t, 2.0ghz, 25W
- MEMORY:16gb ddr3, 1600mhz
- STORAGE: 120gb ssd
- SOFTWARE: Proxmox host OS with 2 x pfsense instances in HA mode(firewall, router, DNS, DHCP, IPS, VPN, Adblocker)
- ADDITIONAL PACKAGES: UPS monitor, load balancer, forward/ reverse proxy, network monitoring (arping, iperf, nmap)
 
#### Virtualization Server
- HP ProDesk 600 G3 SFF
- CPU: i7-6700, 4C/8T, 3.4ghz
- MEMORY: 32gb ddr4, 2400mhz
- STORAGE: 1TB SSD
- SOFTWARE: VMWare ESXi 

#### Storage Server
- HP Proliant Microserver Gen8
- CPU: Xeon E3-1220LV2, 2C/4T, 2.3ghz
- MEMORY: 16gb ddr3 ECC, 1600mhz
- STORAGE: 500gb ssd, 4 x 2tb hdd
- SOFTWARE: TrueNAS host OS
