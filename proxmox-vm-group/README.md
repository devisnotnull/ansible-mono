# Create cluster of VM's

Deploy cluster 

```
ansible-playbook -i inventory.ini ./proxmox-vm-group/site.yml  --extra-vars "masters=k8_rancher_masters minions=k8_rancher_minions proxmox=proxmox-01" 
```

Delete cluster

```
ansible-playbook -i inventory.ini ./proxmox-vm-group/playbooks/optional/delete_all_resources.yml --extra-vars "masters=k8_rancher_masters minions=k8_rancher_minions proxmox=proxmox-01" 
```
