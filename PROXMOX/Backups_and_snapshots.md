## Backups And Snapshots (taken from the instructions provided on dlford.io [website.](https://www.dlford.io/managing-proxmox-how-to-home-lab-part-2/)

#### CREATING A BACKUP OR SNAPSHOT
Backups are a complete representation of a virtual machine, you can take a backup and restore it to a new VM or even a new Proxmox host and spin up a new copy with little to no modification (moving to a new host may require some changes to the network configuration in some cases). You should always have recent backups of critical systems even when you are using a snapshot because backups are superior in versatility, however, they take longer to create and restore from than snapshots.

Snapshots are a representation of a virtual machine’s state rather than the VM in its entirety, that’s an important distinction because you cannot spin up a new VM from a snapshot or move it to a new host using a snapshot. They do however have the advantage of being much faster than a backup to create and restore from.

As a general rule of thumb, if you just want to create a “checkpoint” of a VM before doing a major upgrade or making a risky change, go with a snapshot so you can quickly roll it back if things go awry, and remove the snapshot when you’re finished. For any other use case - just use a backup.

Drill down to the name of your VM on the left-hand menu and click on it, then click the backup tab, and then click the backup now button. The steps for manually working with backups and snapshots are pretty much identical, so I will omit going over snapshots, you can just follow these same steps using the snapshots tab instead of the backups tab

In the options menu, the following options are available:

Storage: Where the backup will be saved to (there is likely only local available right now)
Mode: I always leave this on snapshot, which means the system will take a snapshot before backing up and remove it after the backup is finished, this is so any data that is modified in the VM during backup will be ignored in the backup. Essentially the backup will contain the state that the VM was in when you started the backup, any changes made during the backup will exist only on the running instance and not in the backup.
Compression: I always leave this on LZO, GZIP makes for smaller backups that use up less space but this takes a lot more time to complete.
Send email to: Since we haven’t set up Email alerts yet, we can just leave this blank, it’s for sending the results of the backup when complete.
When the backup is started, you’ll be presented with a progress screen, it is safe to close this and let the backup run in the background if you wish, you can re-open it by double-clicking the backup task in the bottom section of the web interface. It should finish with TASK OK.

If you go back to the backup tab you will see your shiny VM backup listed (if you don’t see it, try clicking another tab in the menu and then click back to the backup tab). The filename will always be something like vzdump-qemu-(VM ID)-(Year)_(Month)_(Day)-(Hour)_(Minute)_(Second).vma.lzo

#### RESTORING FROM A BACKUP
From the backup tab of your target VM, click the name of the backup you want to restore, then click the restore button.
You are given the option to choose which storage device to use (likely your only option right now is local-lvm), and the read limit for this action. The read limit sets the maximum read speed from the source backup file, and subsequently limits the write speed of the restoration process.

#### RESTORE TO A NEW VM FROM BACKUP
You can also do a restore to a VM other than the one originally backed up. From the web interface, drill down to the storage your backups live on (probably local), click the content tab, then the name of the backup, then the restore button.
You have two new options this time, VM ID which is just a numerical identifier that is unique for each VM (don’t use values lower than 100 here!), and the unique checkbox. The unique checkbox will randomize certain values like the MAC address so the network will see this VM as a unique system compared to the originally backed up system, I recommend leaving this checked.

#### Scheduled Backups
The first thing we need to do is figure out how many backups we can store for each VM. To calculate this, we will use the following formula:

(Backup Space Available / Total size of one backup for all VMs) - 1 for extra padding

The - 1 for extra padding is there because when the scheduled backup runs, it will create a new backup before removing the oldest copy, so you need a little extra space for that action.

As an example, if I have 32 GiB of available backup space, and 3 VMs that each take up about 2 GiB per backup, the formula would be:

(32 GiB Available / (3 VMs * 2 GiB each backup)) - 1 (32 / (3*2)) - 1 (32 / 6) - 1 5.33 - 1 = 4.33 Backups

Rounding down, I can store 4 backups for each VM. I am going to set up backups to only save one copy in this tutorial, but I can safely go up to 4 so long as I don’t add more VMs to the backup schedule.

To find the size of each VMs backup, drill down to the name of that VM in the web interface, click the backup tab, and you will find the size of each backup file on the far right, if there are multiple backups use the largest size backup for your calculations.

Now that we have the math stuff out of the way, from the web interface, navigate to datacenter > storage, click on local (or your backup storage if you’ve added extra storage), then click edit.

Next to max backups, enter the number from the calculation above, or just use 1 like I have if you want the maximum breathing room for future VMs.

Next, navigate to datacenter > backup, and click the add button.

Set the target storage and time/days however you like, leave the Send email to field blank since we haven’t set that up yet, and check the box for each VM you want to be backed up on this schedule. You can have as many schedules as you like. Update: It is not required to modify the backup cron job on most systems. If your scheduled backup fails with an error stating the maximum number of backups has been reached, see the steps at the end of this segment to fix that issue.
