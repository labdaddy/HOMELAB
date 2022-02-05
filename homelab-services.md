## Homelab Server one, firewall and storage
HP Microserver Gen8
- CPU: Xeon E3-1220L V2, 2c/4t, 2.3ghz, 17W (!)
- RAM: 16gb ddr3, ECC, 1600mhz
- DISKS: 1x 500GB SSD, 4x 6TB HDD
- SOFTWARE: Rocky Linux (with KVM for VM's), pfsense firewall (with add on packages), mdadm for RAID management
- SERVICES: Firewall/ IPS/ DNS/ DHCP/ Adblocking/ Proxying/ Certificates/ various monitoring, Storage for logs/ ISO & Container images/ Personal photos/ Security cameras


#### Security services on firewall 
- Firewall: Pfsense, [package list](https://docs.netgate.com/pfsense/en/latest/packages/list.html)
- Adblocker: [pfblockerng-devel](https://docs.netgate.com/pfsense/en/latest/packages/pfblocker.html)
- VPN: [OpenVPN](https://docs.netgate.com/pfsense/en/latest/recipes/openvpn-ra.html), setup [Lawrence Systems Video](https://www.youtube.com/watch?v=PgielyUFGeQ)
- IPS: [Suricata](https://suricata.readthedocs.io/en/suricata-6.0.3/)
- Monitoring suite: TBD
- Forward proxy: [squid](https://docs.netgate.com/pfsense/en/latest/recipes/http-client-proxy.html)
- Reverse proxy: [nginx](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- ARP monitoring tool: [arpwatch](https://en.wikipedia.org/wiki/Arpwatch)
- host probe & discovery: [arping](https://docs.netgate.com/pfsense/en/latest/packages/arping.html)
- Dynamic DNS service: [duckDNS](https://www.duckdns.org/)
- Certificate manager: smallstep/ acme
 - UPS monitor: [APCUPSD](http://www.apcupsd.org/manual/manual.html) OR [NUT](https://networkupstools.org/)

#### Storage services
- Storage: RAID 6, mdadm 
- File sync: [syncthing](https://syncthing.net/)
- Photo registry: [photoprism](https://photoprism.app/)
- ISO registry
- Docker registry
- log storage 
- security cameras
- 
## Homelab Server two, virtualization
