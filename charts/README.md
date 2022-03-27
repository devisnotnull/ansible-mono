## Deploy devnotnull ui

## Deploy devnotnull helm repo 

```
helm repo add devnotnull https://devnotnull-helm.s3.eu-west-2.amazonaws.com
```

## Deploy devnotnull ui

```
helm install fandanzle-v2-ui devnotnull/nodejs-template \
--set image.repository=alexbrown201/fandanzle-v2-ui:latest \
--set port=3000 \
--set service.type=LoadBalancer \
--set service.loadBalancerIP=10.150.10.134 \
--set image.pullPolicy=Always
```

## Deploy devnotnull api

```
helm install fandanzle-v2-api devnotnull/nodejs-template \
--set image.repository=alexbrown201/fandanzle-v2-api:latest \
--set port=3005 \
--set service.type=LoadBalancer \
--set service.loadBalancerIP=10.150.10.143 \
--set image.pullPolicy=Always
```

## Deploy redis

```
helm install redis bitnami/redis \
--version 15.3.3 \
--set master.service.type=LoadBalancer \
--set replica.service.type=LoadBalancer \
--set master.service.loadBalancerIP=10.150.10.141 \
--set replica.service.loadBalancerIP=10.150.10.142 \
--set master.persistence.enabled=false \
--set replica.persistence.enabled=false \
--set auth.enabled=false \
--set image.pullPolicy=Always
```