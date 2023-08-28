## Deploy devnotnull ui

## Deploy devnotnull helm repo 

```
helm repo add devnotnull https://devnotnull-helm.s3.eu-west-2.amazonaws.com
```

To install the remote repo 

```
helm repo add devnotnull https://devnotnull-helm.s3.eu-west-2.amazonaws.com
```

To build the local helm images and push it to S3

```
./build.sh
```

## Deploy devnotnull api


## Deploy redis cluster 

```
helm install redis bitnami/redis \
--version 17.10.3 \
--set master.service.type=LoadBalancer \
--set replica.service.type=LoadBalancer \
--set master.service.loadBalancerIP=10.150.10.141 \
--set replica.service.loadBalancerIP=10.150.10.142 \
--set master.persistence.enabled=false \
--set replica.persistence.enabled=false \
--set auth.enabled=false \
--set image.pullPolicy=Always
```

## Deploy devnotnull api

```
helm install \
    --version 2 \
    --set env.NODE_RUNTIME_ENV=production \
    --set env.CDN_BUCKET=production \
    --set image.repository=alexbrown201/devnotnull-api-v2:latest \
    --set port=3005 \
    --set ingress.tls.secretName=letsencrypt-devnotnull-api-tls-host-production \
    --set service.type=LoadBalancer \
    --set service.loadBalancerIP=10.150.10.143 \
    --set image.pullPolicy=Always \
    --set replicaCount=10 \
    --set "ingress.hosts[0].host"=api.devnotnull.com \
    --set "ingress.hosts[0].paths[0].path"=/ \
    devnotnull-api \
    devnotnull/nodejs
```

## Deploy devnotnull ui

```
helm install \
    --version 2 \
    --set env.NODE_RUNTIME_ENV=production \
    --set env.CDN_BUCKET=production \
    --set image.repository=alexbrown201/devnotnull-ui:latest \
    --set port=3000 \
    --set ingress.tls.secretName=letsencrypt-devnotnull-ui-tls-host-production \
    --set service.type=LoadBalancer \
    --set service.loadBalancerIP=10.150.10.134 \
    --set image.pullPolicy=Always \
    --set replicaCount=10 \
    --set "ingress.hosts[0].host"=devnotnull.com \
    --set "ingress.hosts[0].paths[0].path"=/ \
    devnotnull-ui \
    devnotnull/nodejs
```


curl -kivL -H 'Host: devnotnull.com' 'http://10.150.10.102'
