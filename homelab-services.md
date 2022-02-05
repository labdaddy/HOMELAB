### Homelab Services

### Security services on firewall box
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

### Storage services
- Storage: RAID 6, mdadm 

- File sync: [syncthing](https://syncthing.net/)
- Photo registry: [photoprism](https://photoprism.app/)
- ISO registry
- Docker registry
- log storage 
- UPS monitor: [APCUPSD](http://www.apcupsd.org/manual/manual.html) OR [NUT](https://networkupstools.org/)
