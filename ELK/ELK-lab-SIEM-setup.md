## ELK LAB (SIEM) SETUP PART 1

This setup used the wonderful series of articles at LevelEffect.com, [How to setup your own home lab with ELK](https://www.leveleffect.com/blog/how-to-set-up-your-own-home-lab-with-elk)

The diagram below sets the stage:

![image](https://user-images.githubusercontent.com/47070992/212575986-b574b92b-a801-42ee-bb04-d88f87f9aa79.png)

RECOMMENDED Minimum Hardware Requirements:
Operating System	Ubuntu 18.04 (I used 22.04)
RAM	4-8 GB
Storage	50-100 GB
CPU	2+ core processors
Network	Internet connection (for install)

### STEP 1
Install your ubuntu server release of choice. Make sure to install openssh during this installation.

### STEP 2
Login to your new server and run the following commands:
- `sudo apt update && sudo apt upgrade -y`
- `sudo apt dist-upgrade -y`
- `sudo apt install zip unzip -y`
- `sudo apt install jq -y`
- `sudo reboot`

### STEP 3
Install apt-transport-https to enable TLS/SSL-encrypted downloads from repositories and validate their certificates:
- `sudo apt install apt-transport-https -y`

### STEP 4
Add the elastic GnuPrivacyGuard (GPG) key to our VM and add the repo to our apt sources.
- `wget -qO - [<https://artifacts.elastic.co/GPG-KEY-elasticsearch>](<https://artifacts.elastic.co/GPG-KEY-elasticsearch>) | sudo apt-key add - && echo "deb [<https://artifacts.elastic.co/packages/7.x/apt>](<https://artifacts.elastic.co/packages/7.x/apt>) stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list`

We should see an OK to indicate that the GPG key is added and an echo of our /etc/apt/sources entry as a successful output. This will allow us to pull from the elasticsearch repository when we look to install the ELK components and verify that the packages are coming from a trusted source by verifying its GPG key!

### STEP 5
Update the recently added elasticsearch repository and pull from it to install elasticsearch.
- `sudo apt update -y`
- `sudo apt install elasticsearch -y`

### STEP 6
Now we’ll want to reload the known daemons and services on our machine to verify that elasticsearch gets properly added.
- `sudo systemctl daemon-reload`

### STEP 7
Verify that elasticsearch is installed, but not running using systemctl
- `sudo systemctl status elasticsearch.service`

### STEP 8
Now that we’ve installed the elasticsearch application, we need to properly configure it so that it knows how to run, what ports it needs to open, where it needs to communicate. We can configure this by editing the yaml file associated with it.
- `sudo vim /etc/elasticsearch/elasticsearch.yml`

### STEP 9
Edit the /etc/elasticsearch/elasticsearch.yml file to add the following (NOTE: You'll want to be sure to remove the # in front of the cluster.name and other entries. These are comment characters telling elasticsearch not to read those lines when applying settings.)
- `cluster.name: <your lab name here>`
- `nnetwork.host: 192.168.1.150`
- `http.port: 9200`
- `discovery.type: single-node` [this line does not exist in the config file and will need to be added below the ones listed above]

### STEP 10
After you’ve updated the configuration file, start and enable the elasticsearch.service service. This may take a minute or two.
- `sudo systemctl start elasticsearch`
- `sudo systemctl enable elasticsearch`

### STEP 11
Test to make sure elasticsearch is running properly by browsing to our VM’s IP address over port 9200.
- `curl -XGET “192.168.1.150:9200”`

### STEP 12
With the JSON response and tagline “You Know, for Search” we know that our elasticsearch service is running properly on port 9200 and is accessible! This is the port that our beats shippers/agents will use to send data to the elasticsearch database for indexing.

### STEP 13
Install Kibana and Edit the Kibana YML for Configuration
- `sudo apt install kibana -y`

### STEP 14
Edit the /etc/kibana/kibana.yml file with your favorite text editor to add the following:
- `server.port: 5601`
- `server.host: "192.168.1.150"`
- `server.name: "<YourLabNameHere>`

### STEP 15
Start and enable the Kibana service and restart elasticsearch (this is always a good practice when restarting either service as Kibana and elasticsearch are very dependent on each other).
- `sudo systemctl start kibana && sudo systemctl enable kibana`
- `sudo systemctl restart elasticsearch`

### STEP 16
Check the status of both the elasticsearch and Kibana services before moving on to the next step (NOTE: If you run the command as pictured in the screenshot, you will have to press “Q” to see the next output):
- `sudo systemctl status kibana && sudo systemctl status elasticsearch`

### STEP 17
Now that we’ve established the kibana and elasticsearch services on our machine, we can add Logstash to help with any potential logs that elasticsearch may not know how to index by default and filebeat to get some other cool features and monitoring on our VM itself. 
- `sudo apt install logstash -y && sudo systemctl start logstash && sudo systemctl enable logstash`

### STEP 18
Install Filebeat.
- `sudo apt install filebeat -y`

### STEP 19
Edit the /etc/filebeat/filebeat.yml file with your favorite text editor to add the following entry to connect to our elasticsearch service.
================================== Outputs ===================================

Configure what output to use when sending the data collected by the beat.

---------------------------- Elasticsearch Output ----------------------------
output.elasticsearch:
Array of hosts to connect to.
hosts: ["192.168.1.150:9200"]

Now we’ve set up some basic logging to send logs to elasticsearch over port 9200! We’ll want to test it now to make sure it’s collecting logs and sending it for proper indexing. (NOTE: We will have to change this once we start enabling security features.)

### STEP 20
Run the Filebeat setup commands with the following arguments to tell Filebeat we don’t need Logstash logging and to ensure we have the proper host configured in our yml file:
- `sudo filebeat setup --index-management -E output.logstash.enabled=false 'output.elasticsearch.hosts=["192.168.1.150:9200"]' && sudo systemctl start filebeat && sudo systemctl enable filebeat`

### STEP 21
Run another curl command to check and make sure our indices are working properly to ingest the logs from Filebeat.
- `curl -XGET http://192.168.1.150:9200/_cat/indices?v`





















