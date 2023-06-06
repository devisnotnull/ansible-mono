# Install

## Production

Deploy Kubenetes cluster 

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/site.yml  --extra-vars "masters=k8_prod_masters minions=k8_prod_minions proxmox=proxmox-01" --start-at-task="Including the variables package."

--start-at-task="Installing the required packages to bootstrap a kubernetes cluster."
```

Delete cluster

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/playbooks/optional/delete_all_resources.yml --extra-vars "masters=k8_prod_masters minions=k8_prod_minions proxmox=proxmox-01" 
```

Deploy MetalLB

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/playbooks/helm/deploy_metallb.yml --extra-vars "masters=k8_prod_masters minions=k8_prod_minions proxmox=proxmox-01" 
```

Deploy Devnotnull.com production resources

```
helm upgrade --install redis bitnami/redis --version 16.12.1 \
  --set master.service.type=LoadBalancer \
  --set replica.service.type=LoadBalancer \
  --set master.service.loadBalancerIP=10.150.10.141 \
  --set replica.service.loadBalancerIP=10.150.10.142 \
  --set master.persistence.enabled=false \
  --set replica.persistence.enabled=false \
  --set auth.enabled=false \
  --set image.pullPolicy=Always
```

```
helm upgrade --install devnotnull-api devnotnull/nodejs --version 2 \
  --set env.NODE_RUNTIME_ENV=production \
  --set env.CDN_BUCKET=production \
  --set image.repository=alexbrown201/devnotnull-api-v3:latest \
  --set port=3000 \
  --set service.type=LoadBalancer \
  --set service.loadBalancerIP=10.150.10.143 \
  --set image.pullPolicy=Always \
  --set replicaCount=10
```

```
helm upgrade --install devnotnull-ui devnotnull/nodejs --version 2 \
  --set env.NODE_RUNTIME_ENV=production \
  --set env.CDN_BUCKET=production \
  --set image.repository=alexbrown201/devnotnull-ui:latest \
  --set port=3000 \
  --set service.type=LoadBalancer \
  --set service.loadBalancerIP=10.150.10.134 \
  --set image.pullPolicy=Always \
  --set replicaCount=10
```

## Development

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/site.yml  --extra-vars "masters=k8_test_masters minions=k8_prod_minions proxmox=proxmox-01" 
```

Delete cluster

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/playbooks/optional/delete_all_resources.yml --extra-vars "masters=k8_test_masters minions=k8_test_minions proxmox=proxmox-01" 
```

Deploy MetalLB

```
ansible-playbook -i inventory.ini ./proxmox-kubernetes/playbooks/helm/deploy_metallb.yml --extra-vars "masters=k8_testmasters minions=k8_test_minions proxmox=proxmox-01" 
```

Deploy Devnotnull.com development resources

```
helm upgrade --install redis bitnami/redis --version 16.12.1 \
  --set master.service.type=LoadBalancer \
  --set replica.service.type=LoadBalancer \
  --set master.service.loadBalancerIP=10.150.10.141 \
  --set replica.service.loadBalancerIP=10.150.10.142 \
  --set master.persistence.enabled=false \
  --set replica.persistence.enabled=false \
  --set auth.enabled=false \
  --set image.pullPolicy=Always
```

```
helm upgrade --install devnotnull-api devnotnull/nodejs --version 2 \
  --set env.NODE_RUNTIME_ENV=production \
  --set env.CDN_BUCKET=production \
  --set image.repository=alexbrown201/devnotnull-api-v3:latest \
  --set port=3000 \
  --set service.type=LoadBalancer \
  --set service.loadBalancerIP=10.150.10.143 \
  --set image.pullPolicy=Always \
  --set replicaCount=10
```

```
helm upgrade --install devnotnull-ui devnotnull/nodejs --version 2 \
  --set env.NODE_RUNTIME_ENV=production \
  --set env.CDN_BUCKET=production \
  --set image.repository=alexbrown201/devnotnull-ui:latest \
  --set port=3000 \
  --set service.type=LoadBalancer \
  --set service.loadBalancerIP=10.150.10.134 \
  --set image.pullPolicy=Always \
  --set replicaCount=10
```