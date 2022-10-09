###REMOVE THE PROXMOX SUBSCRIPTION NAG AFTER LOGIN
- open the shell in the proxmox node and enter: `sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
`
- log out 
- clear the browser cache
- log back in, no subscription nag !
