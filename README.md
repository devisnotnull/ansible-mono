## Homelab bootstrap

Create your cluster.

You will need to declare your 

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/site.yml  --extra-vars "master=master1 proxmox=proxmox"
```