helm repo add ckotzbauer https://ckotzbauer.github.io/helm-charts
helm install my-nfs-client-provisioner ckotzbauer/nfs-client-provisioner \
    --version 1.0.2 \
    --set storageClass.defaultClass=true \
    --set nfs.server=nas.devnotnull.com \
    --set nfs.path=/mnt/Primary/proxmox_backup \
    --set storageClass.name=nfs \
    --set storageClass.accessModes=ReadWriteOnce

# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
# this one works
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=nas.devnotnull.com \
    --set nfs.path=/mnt/Primary/proxmox_backup \
    --set storageClass.defaultClass=true \
    --set storageClass.name=nfs \


helm repo add longhorn https://charts.longhorn.io
helm install longhorn longhorn/longhorn --version 1.2.0 --set ui.serviceType=LoadBalancer

helm install redis bitnami/redis --version 15.3.3 --set master.service.type=LoadBalancer --set replica.service.type=LoadBalancer

helm install kong bitnami/kong --version 4.1.1 --set service.type=LoadBalancer

helm install jenkins jenkinsci/jenkins --version 3.5.19 --set controller.serviceType=LoadBalancer --set persistence.enabled=true  --set persistence.storageClass=longhorn

helm install vault hashicorp/vault --version 0.16.0 --set ui.serviceType=LoadBalancer --set persistence.enabled=false  --set persistence.storageClass=longhorn

helm install wordpress bitnami/wordpress --set persistence.enabled=false --set persistence.storageClass=longhorn