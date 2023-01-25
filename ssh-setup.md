### OpenSSH setup
- Install openssh: `sudo yum –y install openssh-server openssh-clients`
- To start ssh: `sudo systemctl start sshd`
- To check ssh status: `sudo systemctl status sshd`
- To stop ssh: `systemctl stop sshd`
- To enable ssh to start automatically after each system reboot by using the systemctl command: `sudo systemctl enable sshd`
- To disable ssh persistence after reboot enter: `sudo systemctl disable sshd`
##### Create a hosts file of servers you want to repeatedly log into so you dont have to enter IP addresses every time
- Change to ssh directory: `cd .ssh`
- Open vi and add the host data:
- `vi config`
- `Host server1`
- `HostName [ip address]`
- `User root`
- `Port 22`
- Then save and exit


##### Ssh server configuration is needed to harden server security. The most common settings to enhance security are changing the port number, disabling root logins, and limiting access to only certain users. To edit these settings access the /etc/ssh/sshd_config file: `sudo vim /etc/ssh/sshd_config`
##### Disabling root logins and editing the default port number are good places to start.
- Disable root login: `PermitRootLogin no`
- Change the SSH port to run on a non-standard port. For example: `Port 2002`
##### Save the file after edits and restart sshd: `service ssh resart`

- To access a remote host type: `ssh ipaddress` or `ssh username@ipaddress`.
- Logging in to a remote machine with `ssh ipaddress' the remote machine will assume you intend to use the same username you are currently logged in as.
- Logging in as `ssh username@ipaddress` you will be prompted for the password of the user you are attempting to login as.

##### Key based authentication is even more secure than logging in with passwords and should be setup right away. The generated key will be distributed to the other servers to alow authentication to these servers from the master machine. The steps look like this:
- ssh-keygen 
- ssh-copy-id 
- ssh-agent
- ssh-add
- authorized_keys
- 
##### Detailed instructions follow.
- Generate a public key on the first server: `ssh-keygen -t rsa -b 4096`. This creates an RSA type public key to share with the remote server.
- The system  will prompt for a passphrase which should be different than any password used on either system.
- Verify key has been created: `cd .ssh`
- List the contents of the ssh directory: `cd .ssh` then `ls`
- Should show this: `id_rsa id_rsa.pub known_hosts`. The known_hosts file now has the public key, id_rsa.pub and id_rsa files have the public and private keys of my user account (root).
- Make sure you and only you have access to this file with: `chmod 700 .ssh`
- Next we need to get this PUBLIC key onto the target server.
- This can be accomplished using secure copy or scp: `ssh-copy-id -i id_rsa.pub server2` (or whatever name you put into the known_host file) OR BY USING `scp .ssh/id_rsa.pub {destination} username@IPaddress:/path/to/file` 
- The system will ask for the password and then show: `id_rsa.pub` to indicate successful copy.
- Now we check to make sure it works: `ssh {servername}`. Enter password for key authentication when prompted. And now we should be on the other server. To verify this type: `ip a s` this will display ip address of the server you are logged into and should indicate that you are in fact on the remote server.
- Now to make sure that everything is in order, check the authorized keys file: cat .ssh/authorized_keys. Should show a huge public key.

##### Advanced ssh with agents
- Agents allow us to ssh into the remote target machine without typing the passphrase every time. This is super convenient but also dangerous.
- `ssh-agent bash` then `ssh-add` This will prompt for the password.
- Now to ssh into remote servers just use `ssh server2` or whatever server names is in the known_hosts file

##### Configure SSH to be more secure
- Login to the remote machine
- `vi /etc/sh/ssh/sshd_config`
- Scroll down to the line that reads `PermitRootLogin yes` and uncomment the line and change the yes part to `without-password`. This ensures that you can only connect if you have preshared the key as root. 
- Save and exit.
- Restart the ssh service: `systemctl restart sshd`
- Type: `exit`
- Now double check with: `ssh servername`
- Should allow login with no password prompt 
- No need to authenticate !

