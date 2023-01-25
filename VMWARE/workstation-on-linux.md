### Installing VMware Workstation on Linux
Go to the directory where you saved the downloaded installer file. In the current example the VMware Workstation installer is located in the Downloads directory:

cd /home/user1/Downloads/

Make the installer file executable:

sudo chmod +x ./VMware-Workstation-Full-15.0.2-10952284.x86_64.bundle

Run the VMware Workstation Linux installer:

sudo ./VMware-Workstation-Full-15.0.2-10952284.x86_64.bundle

The installation wizard window now appears. Answer the questions provided by the wizard and click Next for switching to the next step.

Accept the license agreement.
Would you like to check for product updates on startup? Select Yes or No.
Would you like to join the VMware Customer Experience Improvement Program? Select Yes or No.
Enter the user that will initially connect to the Workstation Server. Type the user name of the account you are using in Linux.
Choose a directory for your shared virtual machines, for example, /var/lib/VMware/SharedVMs
Enter the port to use for HTTPS access to Workstation Server (443 by default).
Enter the license key. Keep this field empty for the free trial mode.
The product is ready to be installed.
GNU C Compiler must be installed before running the VMware Workstation. In order to install this compiler, execute the command:

sudo apt-get -y install gcc make linux-headers-$(uname -r) dkms

The interfaces of VMware Workstation for Linux and for Windows are identical. Below you can see the screenshot of the interface of VMware Workstation 15 running on Linux.

### Installing VMware Workstation on Windows
Go to the directory where you saved the downloaded installer and run the installer file. The name of the file is VMware-workstation-full-15.0.2-10952284.exe in this case. Similarly to the installation on Linux, a wizard opens. After configuring options click Next for switching to the next step of the wizard.

On the Welcome screen click Next.
Accept the license agreement.
Select the installation destination.
Tick the checkboxes if you want to check for updates on startup and join the VMware Customer Experience Improvement Program.
Select the shortcuts you wish to place on your system.
Hit Install to begin the installation.
The final installation screen allows you to enter a license (is not necessary for a free trial mode).
