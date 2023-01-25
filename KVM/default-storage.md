##### Libvirt Storage Pools
- A storage pool can be used in many ways. See the libvirt details (here)[https://libvirt.org/storage.html].

##### Using the virt-manager GUI, to change the default storage location from "/" to something more useful.
- The default storage pool for VM iso images is in the root partition at /var/lib/libvirt/images. The root partition typically has a really limited amount of storage space and also running VM's out of the root partition is crazy pants so it makes sense to change this to some other partition. In the following example I will change the storage pool to one of my home directories that has plenty of storage.
- If you are using virt-manager GUI program, changing the default storage pool is very easy. Go to “Edit” -> “Connection Details” in virt-manager menu GUI. You will see the default storage pool. On the left bottom of the window, click on the red cross icon, which will stop the default storage pool. Once the pool is stopped, click on the trash bin icon / or the little "x" in a circle icon on the right, which will delete the pool. Note that this action will NOT remove the VM images inside the pool. 
- Now click on the plus icon on the far left to add a new storage pool. Type in the name of a new storage pool (e.g., default), and choose the type of the pool. In this case, choose a “filesystem directory” type since we are simply changing a storage pool directory. Type in the path of a new storage pool (e.g., /home/notyollama/vmstorage).



##### This section is still under construction
Now click on the plus icon on the far left to add a new storage pool.
- Create a Default storage pool. The “default” storage pool for guest disks is “/var/lib/libvirt/images”. This is fine for test purposes, but if you have another mount that you want to use for guest OS disks, then you should create a custom storage pool. Commands to create a “kvmpool” on an SSD mounted at “/data/kvm/pool”. At this point, the new storage pool should be started, and automatically used when you create a new VM.
- `virsh pool-list --all`   
 - `virsh pool-define-as kvmpool --type dir --target /data/kvm/pool`
 - Should return: `Pool kvmpool defined`
 - `virsh pool-list --all`
 - `virsh pool-start kvmpool`
 - `virsh pool-autostart kvmpool`
 - `virsh pool-list --all`
 - Should return: 
 Name                 State      Autostart 
-------------------------------------------
 default              active     yes 
 kvmpool              active     yes
