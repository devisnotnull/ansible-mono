# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
# this one works
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=nas.devnotnull.com \
--set nfs.path=/mnt/Tank/proxmox-backup \
--set storageClass.defaultClass=true \
--set storageClass.name=nfs

##
## 
helm repo add longhorn https://charts.longhorn.io
helm install longhorn longhorn/longhorn --version 1.2.0 --set ui.serviceType=LoadBalancer

##
## 

helm install redis bitnami/redis --version 15.3.3 --set master.service.type=LoadBalancer --set replica.service.type=LoadBalancer

##
## 

helm install kong bitnami/kong --version 4.1.1 --set service.type=LoadBalancer

##
## 

helm install jenkins jenkinsci/jenkins --version 3.5.19 --set controller.serviceType=LoadBalancer --set persistence.enabled=true

##
## 

helm install vault hashicorp/vault --version 0.16.0 --set ui.serviceType="LoadBalancer" 

##
## 
helm install wordpress bitnami/wordpress --set persistence.enabled=true --set service.type=LoadBalancer

##
## 
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install my-kube-prometheus-stack prometheus-community/kube-prometheus-stack --version 19.0.1

##
## 
kubectl apply -f https://10.150.10.230/v3/import/xlbdr54gsxf4vwxpqxbvwjcfmlt9x2qhlbwmm4c6hdl6vqm82kjgbw_c-m-4prcvtbd.yaml

##
## 
helm install redis bitnami/redis --version 15.5.5 --set master.service.type=LoadBalancer

##
## 
helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com

##
## 
helm install my-argo banzaicloud-stable/argo --version 0.2.2
