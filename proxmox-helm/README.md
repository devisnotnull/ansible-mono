## 

```
helm install fandanzle-ui bitnami/node \
    --set image.repository=alexbrown201/fandanzle-v2:stable \
    --set port=3000 \
    --set mongo.enabled=false \
    --set service.type=LoadBalancer \
    --set service.loadBalancerIP=10.150.10.134 \
    --set image.pullPolicy=Always
```

```
helm install fandanzle-ui banzaicloud-stable/nodejs \
    --set image.repository=alexbrown201/fandanzle-v2:stable \
    --set internalPort=3000 \
    --set externalPort=80 \
    --set service.type=LoadBalancer \
    --set service.loadBalancerIP=10.150.10.134 \
    --set image.pullPolicy=Always
```

```
helm install fandanzle-api bitnami/node  \
    --set image.repository=alexbrown201/fandanzle-v2:stable \
    --set port=3000 \
    --set mongo.enabled=false \
    --set service.type=LoadBalancer \
    --set service.loadBalancerIP=10.150.10.143 \
    --set image.pullPolicy=Always
```

```
helm install redis bitnami/redis \
    --version 15.3.3 \
    --set master.service.type=LoadBalancer \
    --set replica.service.type=LoadBalancer \
    --set master.service.loadBalancerIP=10.150.10.141 \
    --set image.pullPolicy=Always
```