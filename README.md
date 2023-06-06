## Homelab bootstrap

Create your cluster.

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/site.yml  --extra-vars "master=master1 proxmox=proxmox"
```

Delete your cluster.

```
ansible-playbook -i inventory.ini ./proxmox-haproxy/playbooks/optional/delete_all_resources.yml --extra-vars "proxmox=proxmox-01"
```

Create your cluster.


```
ansible-playbook -i inventory.ini ./proxmox-kubernetes-k3s/site.yml  --extra-vars "masters=k3s_prod_masters minions=k3s_prod_minions proxmox=proxmox-01" -vvv
```

Delete your cluster.

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes-k3s/playbooks/site.yml  --extra-vars "masters=k3s_prod_masters minions=k3s_prod_minions proxmox=proxmox-01"
 ```