### NESTED ESXI 7.0 ON TOP OF PROXMOX

#### ENABLE NESTED VIRTUALIZATION (for ESXI) ON THE PROXMOX HOST MACHINE
PROXMOX HOST CONSOLE
- `echo 'options kvm ignore_msrs=y' >> /etc/modprobe.d/kvm-intel.conf `      # Intel-only
- `echo 'options kvm-intel nested=Y ept=Y' >> /etc/modprobe.d/kvm-intel.conf` # Intel-only
- `reboot`

#### CREATE THE VM
Follow the normal VM creation process except as noted below:

- OS Tab\
Make sure for ISO Image, we have selected vSphere 7.0 installer iso file\
Type: Linux\
Version: 5.x – 2.6 Kernel

- System Tab\
Graphic card: Default\
SCSI Controller: VMware PVSCSI\
BIOS: SeaBIOS (OVMF (UEFI) should work too)\
Machine: q35

- Hard Disk Tab\
Bus/Device: SATA\
SSD emulation: Check\
Discard: Check

- CPU Tab\
Cores: as needed\
Type: host\
Enable NUMA: Check if our system supports

- Memory Tab\
Memory (MiB): 4096 (At least 4096, but to test all features 8192 – 16384 MiB will be better, that is 8G – 16G)\
Ballooning Device: Uncheck

- Network Tab\
Model: VMware vmxnet3

### Finish VM creation but DO NOT start the VM yet

#### Go back to the proxmox console

#### PROXMOX HOST CONSOLE
- `echo 'args: -machine vmport=off' >> /etc/pve/qemu-server/VM_ID.conf` #replace VM_ID with the ID number you assigned to the VM
- `qm start VM_ID` #replace VM_ID with the ID number you assigned to the VM

 Start the VM and run through the normal ESXi 7.xx installation process
