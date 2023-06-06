
#!/bin/sh

qm create 80000 --name home-assistant --bios ovmf --boot order=virtio0 --machine q35 --cores 4 --memory 4096 --scsihw virtio-scsi-pci --net0 model=virtio,bridge=vmbr3 --agent enabled=1 --tablet 0
qm set 80000 --efidisk0 Pool1:1,format=raw
wget https://github.com/home-assistant/operating-system/releases/download/9.0/haos_ova-9.0.qcow2.xz
qm importdisk 80000 haos_ova-9.0.qcow2 Pool1
qm set 80000 --virtio0 Pool1:vm-80000-disk-1