## Homelab Hardware


### SRV01 (prod network)
- Lenovo M720q Tiny
- Specs: i5-8500, 6C/6T, 32gb ram, 2tb nvme

DONE:
[esxi 7.0](https://www.nakivo.com/blog/vmware-vsphere-7-installation-setup/)

[vcenter server](https://www.nakivo.com/blog/vmware-vsphere-7-installation-setup/)

[pfsense](https://docs.netgate.com/pfsense/en/latest/recipes/virtualize-esxi.html) firewall, routing, dhcp
 
[Pihole (DNS blackhole)](https://yewtu.be/watch?v=FnFtWsZ8IP0)
 
[DDNS on pfsense](https://www.wundertech.net/use-duckdns-to-set-up-ddns-on-pfsense/)

WAITING:
[Zabbix (monitoring, requires vcenter)](https://bestmonitoringtools.com/vmware-monitoring-with-zabbix-esxi-vcenter-vm-vsphere/)

[Graylog (logging)](https://go2docs.graylog.org/5-0/downloading_and_installing_graylog/operating_system_packages.htm)

[TIG stack, (metrics, dashboards)](https://www.howtoforge.com/how-to-install-tig-stack-telegraf-influxdb-and-grafana-on-ubuntu-22-04/)

OpenVPN (with Turnkey linux) [Example](https://www.wundertech.net/how-to-set-up-openvpn-on-pfsense/)
 
### SRV02 (test network)
- Dell Optiplex 3060 Micro
- Specs: Intel i7-8700T, 6C/12T, 64gb ram, 1tb SSD
- Hypervisor: ESXi 7.0, VCSA
- DONE:
Proxmox 7.3

WAITING:
Secure network (Cybersecurity for small networks book)

Wireguard VPN (with Turnkey linux), site to site access to AWD

- WIFI: setup WAP for SDR practice
- 
- CCTV: setup AVA camera, use practice cam traffic [Testcamera software](https://support.networkoptix.com/hc/en-us/articles/360018067074-TestCamera-IP-Camera-Emulator "‌")

[Setup a SIEM: ELK stack](https://www.leveleffect.com/blog/how-to-set-up-your-own-home-lab-with-elk "‌") 

[Security Onion Setup](https://thecyberdudes.com/2021/03/20/setting-up-security-onion/)

[Setup Splunk]: see [hackersploit's blue team series (splunk section)](https://yewtu.be/playlist?list=PLBf0hzazHTGNcIS_dHjM2NgNUFMW1EZFx)

[Detection lab](https://detectionlab.network/introduction/)

[Zabbix for Proxmox (monitoring)](https://homegrowntechie.com/installing-zabbix-for-homelab-monitoring/)

### NAS01 (storage)
- HP Proliant Microserver Gen8
- Specs: Xeon E3-1230 V2, 4C/8T, 16gb ram, 250gb boot drive, 4 x 6tb hdd
- Hypervisor: TrueNAS SCALE

## DEPRECATED HARDWARE
- HP ProDesk 600 G3 SFF
- CPU: i7-6700, 4C/8T, 3.4ghz
- MEMORY: 32gb ddr4, 2400mhz
- STORAGE: 1TB SSD
- SOFTWARE: VMWare ESXi 
