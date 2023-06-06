## 

```
ansible-galaxy install mrlesmithjr.elk-kibana
ansible-galaxy install geerlingguy.java
ansible-galaxy install geerlingguy.elasticsearch
ansible-galaxy install geerlingguy.kibana
ansible-galaxy install cloudalchemy.grafana

ansible-playbook -i inventory.ini ./proxmox-elk/site.yml --extra-vars "etcd=etcd proxmox=proxmox-01" -vvv
```
