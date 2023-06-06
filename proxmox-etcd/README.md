# Install

## Production

```
ansible-galaxy install andrewrothstein.etcd-cluster
```

Deploy Kubenetes cluster 

```
ansible-playbook -i inventory.ini ./proxmox-etcd/site.yml 
```

