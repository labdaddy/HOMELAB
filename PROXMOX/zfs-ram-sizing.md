# PROXMOX ZFS

ZFS uses 50 % of the host memory for the Adaptive Replacement Cache (ARC) by default. Allocating enough memory for the ARC is crucial for IO performance, so reduce it with caution. As a general rule of thumb, allocate at least 2 GiB Base + 1 GiB/TiB-Storage. For example, if you have a pool with 8 TiB of available storage space then you should use 10 GiB of memory for the ARC.

You can change the ARC usage limit for the current boot (a reboot resets this change again) by writing to the zfs_arc_max module parameter directly:

echo "$[10  _1024_1024*1024]" >/sys/module/zfs/parameters/zfs_arc_max

## To permanently change the ARC limits

Create the file: `vi /etc/modprobe.d/zfs.conf` and write memory limits in it. 
Remember it will use a number of bytes based on gibibytes not gigabytes. So 1 gibibyte is 1073741824 bytes. 8 gibibytes is 8589934592. This is slightly different than gigabytes.

(for example, this is for 8G max and 2G min)

options zfs zfs_arc_max=8589934592

options zfs zfs_arc_min=2147483648

Save that file, then execute `update-initramfs -u`

Reboot.

You should now have limited ZFS to 4 GB ram usage.

It's true that on Linux ZFS does not relase RAM.
