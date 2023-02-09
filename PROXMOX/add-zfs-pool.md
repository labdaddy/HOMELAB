### CREATE AND ADD ZFS POOL
- Go to node_name and click on `Disks` then click on `ZFS`
- On the ZFS page click on `create`, then give your pool a name, then select the RAID level in the dropdown. 
- Make SURE to uncheck the box that says `Add storage`. This is super strange and unintuitive but if this box is left checked, you will not be able to use this storage pool for most types of data storage. So make sure it is UNCHECKED.
- Leave `compression` and `ashift` as is and click `create`. Now the pool is created.

### CREATE AND ADD DATASETS
- Once the pool is created go back to node_name and click on `shell`
- In the shell enter `zfs create pool_name/data_set_name -o mountpoint=/mnt_point`. Replace pool_name with the name of the pool you just created. Replace data_set_name with the name you want for your dataset. Replace mount_point with the mountpoint of your choice.
- Once finished go back to the main Proxmox GUI and click on `datacenter` then click on `storage`.
- On the `storage` page click `add`, select `Directory` from the dropdown and give your directory and ID that is the same as the data_set_name you chose above. 
- In the `Directory` field use the same mountpoint from the mountpoint you chose on the command line above.
- In the `Content` field, use the dropdown menu and highlight all the choices to allow you to save any of those data types to your dataset.
- Click `add` and now the dataset is available to use (in the Proxmox GUI under node_name)
