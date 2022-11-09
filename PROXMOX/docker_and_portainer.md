### Quick way to install Docker and Portainer on Proxmox (this was found on the internet at [getmethegeek.com](https://getmethegeek.com/blog/2020-04-20-installing-docker-and-portainer-on-proxmox/)).
I have one of my Proxmox machines up and one of the first things you will want to do is to update.

`apt update && apt dist-upgrade -y`

The next thing we will do is install a few things that will be needed by default, it will install packages to allow apt to use a repository over https.

`apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common`

Next follow it with these commands.

`curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -`

`apt-key fingerprint 0EBFCD88`

`add-apt-repository “deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable”`

Now you will want to do another update.

`apt-get update`

And now install Docker and say yes to any.

`apt-get install docker-ce docker-ce-cli containerd.io`

Now Docker is installed and we will continue on to install Portainer. We now need to create an area for Portainer to have data.

`mkdir /portainer mkdir /portainer/data`

Now we will do a Docker run Portainer

`docker run -d -p 9000:9000 -v /portainer/data:/data -v /var/run/docker.sock: /var/run/docker.sock portainer/portainer`

Now when you go to the address you should see Portainer and it will have you setup an admin login. You will see docker in there and we used portainer to have GUI.

One last thing you will want to do is have docker run on bootup.

`systemct1 enable docker`
