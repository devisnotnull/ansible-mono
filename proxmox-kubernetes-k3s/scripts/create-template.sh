/etc/pve/priv/authorized_keys

qm create 50000 --pool Kubernetes --ostype "l26" --name minion5.k8 --agent 1 --cores 4 --memory 12288 --net0 "virtio,bridge=vmbr0,tag=900" --ipconfig0 "gw=10.150.10.1,ip=10.150.10.230/24" --nameserver 10.150.10.1 --searchdomain devnotnull.com --sshkeys /etc/pve/priv/authorized_keys
qm importdisk 50000 hirsute-server-cloudimg-amd64.img "Pool1"
qm set 50000 --cipassword password --scsihw virtio-scsi-pci --scsi0 proxmox-01:vm-50000-disk-0 --ide2 proxmox-01:cloudinit --boot c --bootdisk scsi0 --serial0 socket --onboot 1
qm resize 50000 scsi0 100G

docker logs  6f07382f715c  2>&1 | grep "Password:"
