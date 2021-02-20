### Solve connectivity issues casued by pfsense
If you are running pfsense in a vm and you are having connection issues in your other vm's try this:
- Run the command  `ping google.com`, if you get responses, try the command `curl -I google.com`, if that fails but the ping command works fine, go back to your pfSense admin page and head to System > Advanced > Networking, check the box Disable hardware checksum offload and click save.
