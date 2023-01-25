### From [this web article](https://searchservervirtualization.techtarget.com/tip/Sizing-server-hardware-for-virtual-machines) 
Copied here for reference.

IT administrators frequently ask how many VMs can fit on a host server when deciding which hardware options to purchase for their virtual hosts. Admins must consider the current and future needs of their virtual environment when server sizing for different types of VMs by taking memory, CPU, network and disk resources into consideration.

VMs are a result of hardware virtualization where software abstracts and emulates hardware systems. VMs host operating systems in independent environments as a substitution for a physical machine. A hypervisor, such as Hyper-V Manager or VMware vSphere, creates, manages and retires VMs.

You might be able to fit as many as 100 VMs on a single host or even two hosts. The types of applications running on your VMs will largely dictate how many you can put on your host server. For example, you must choose between servers that have very light resource requirements, such as web, file and print servers, and servers with medium to heavy resource requirements, such as SQL and Exchange servers.

Overall, you should analyze the performance usage of your current environment to get a better understanding of the virtual environment's requirements. Using monitoring software such as Nagios can help you to add drives that fit specific needs regarding capacity, performance and scalability. It's good practice to monitor your IT environment specifically for sizing criteria before implementing virtualization.

There are four major criteria to consider when server sizing for virtualization: memory, CPU, the network and disk resources. Let's start with memory, which is typically exhausted on host servers first.
Allocate just enough memory for VMs

When it comes to figuring out how much RAM to put in a host server, you should install the maximum amount if possible; RAM has a direct connection to the processors and reduces the need for disk storage access.

Yet, you should use the opposite mentality when it comes to allocating memory for virtual servers, only giving a VM the exact amount of memory it needs. Usually, with physical servers, admins install more memory than they need, and much of it ends up being wasted.

With a VM, it's simple to increase RAM at any time, so start out with the minimum amount of memory you think you might need and increase it later if necessary. Host machines should have at least as much physical RAM as the RAM needed for each VM hosted by the physical machine.

You must also avoid memory overcommitment, which is the process of assigning more memory to a VM than the physical machine has. It's possible to overcommit memory to VMs and assign more RAM to them then the physical host actually has. By doing this, you run the risk of having your VMs swapping to disk when the host memory is exhausted, which can cause decreased performance, such as increasing CPU wait times and latency. To avoid this, you should continually monitor memory usage.
Increase the number of CPUs

With the advent of multicore processors, it has become easier and cheaper to increase the number of processors, or CPUs, on a host server. CPUs operate on all of the instructions that drive a computer. The more cores a CPU has, the more instructions it can handle at one time.

A CPU that can only process one set of instructions at a time is known as a single-core processor. A CPU that can process two sets of instructions at a time is a dual-core processor; four sets of instructions at one time is a quad-core processor. Today's common servers, such as blade servers, tout four to eight processor cores, but processor packages with 12-24 cores are readily available in rackmount servers, for example.

A good rule of thumb is that a CPU core can support four single CPU VMs. This can vary by as much as 1-2 per core up to 8-10 per core based on the average CPU utilization of applications running on VMs.

One six-core CPU, for example, can hold multiple single-core VMs depending on each VM's load. A common misconception with virtual server hardware is that a VM can utilize as much CPU clock as it needs from the combined total available.

CPU chips work on frequencies known as clock cycles per second, which is commonly measured in GHz. So, for example, a quad-core 2.6 GHz processor would have a combined total of 20,800 megahertz -- 8 x 2.6 GHz. A single virtual CPU (vCPU) VM, however, can never use more clock than the maximum of one CPU/core. If a VM has 2 vCPUs, it can never use more clock than the maximum of each CPU/core. How many cores you need also depends on whether or not you're using multiple vCPU VMs.

When server sizing, you should always have at least one more core than the maximum number of vCPUs assigned to a single VM. For example, don't buy a two-processor, dual-core server with a total of four cores and try to run a four vCPU VM on it. The reason being that the CPU scheduler of the hypervisor needs to find four free cores simultaneously each time the VM makes a CPU request. If there are only a total of four available cores, performance can suffer. If possible, use quad-core CPUs, as more cores can provide the CPU scheduler with more flexibility to process requests.
Use at least four network interface cards

The number of network interface cards (NICs) needed in a virtual server varies based on the level of redundancy you desire -- whether or not you use network storage -- and which features you select.

Using 802.1Q virtual local area network (VLAN) tagging provides flexibility when using multiple VLANs on a single NIC, thus eliminating the need to have a separate NIC for each VLAN on a host server. NIC teaming is the process of grouping multiple VNICs across multiple physical NICs. NIC teaming provides additional network redundancy and bandwidth.

For smaller servers, you can get away with using two NICs, but it's best to a have a minimum of four NICs on your host server. If you use network storage, such as iSCSI, it would be wise to have more than four NICs, especially if you're going to use features like VMware's vMotion. Other storage technologies such as Fibre Channel use dedicated storage networking adapters. When creating vSwitches, it's best to assign multiple NICs to them for redundancy and for the increased capacity available to VMs.
Ensure disk capacity for future needs

Finally, when server sizing, you must evaluate disk resources. There are many choices available, and which tool you choose will largely depend on your budget and if you have a storage area network available in your environment. Network disks provide flexible network-based storage.

You can virtualize hard disk drives (HDDs) as virtual hard disks or as pass-through disks. Pass-through disks are physical disks that connect to a VM as storage for virtual disks. Pass-through disks retain previous disk and file formats.

You can use standard HDDs or high-performance solid-state drives (SSDs) for storage depending on your application needs. In deciding what type of disk to use, you should determine the storage tier your application needs. You can use a traditional HDD when you don't need top-of-the-line storage. Not every application needs an SSD.

Using 15,000 hard drives offers higher performance than using 10,000 drives, but it's also important to have larger RAID groups available to help spread the disk I/O across as many drive spindles as possible.

When determining how much disk to buy, make sure you have enough storage available for all of your VMs to use, plus an additional 10-20% for additional VM files and snapshots. If you plan on making heavy use of snapshots, you might want even more disk space. In many cases, you can use a combination of disk resources with your hosts; for example, storing development and test VMs on a local disk while keeping production VMs on shared storage.

Typically, you want VMs using at least 80% of the capacity of your host server to maximize your investment. However, you must leave enough spare capacity for future growth and ensure there are enough resources available to support additional VMs in case of a host failure.

When server sizing, it's better to have too much capacity than not enough so you can avoid constraining your resources and prevent the need to purchase additional host servers.
