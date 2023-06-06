

## Deploy devnotnull UI

```
helm install \
    --version 2 \
    --set env.NODE_RUNTIME_ENV=production \
    --set env.CDN_BUCKET=production \
    --set image.repository=alexbrown201/devnotnull-ui:latest \
    --set port=3000 \
    --set service.type=LoadBalancer \
    --set service.loadBalancerIP=10.150.10.134 \
    --set image.pullPolicy=Always \
    --set replicaCount=10 \
    --set "ingress.hosts[0].host"=api.local \
    --set "ingress.hosts[0].paths[0].path"=/ \
    --set "ingress.hosts[1].host"=devnotnull.com \
    --set "ingress.hosts[1].paths[0].path"=/ \
    devnotnull-ui \
    devnotnull/nodejs
```

## Deploy devnotnull API

```
helm install \
    --version 2 \
    --set env.NODE_RUNTIME_ENV=production \
    --set env.CDN_BUCKET=production \
    --set image.repository=alexbrown201/devnotnull-api-v3:latest \
    --set port=3000 \
    --set service.type=LoadBalancer \
    --set service.loadBalancerIP=10.150.10.134 \
    --set image.pullPolicy=Always \
    --set replicaCount=10 \
    --set "ingress.hosts[0].host"=api.local \
    --set "ingress.hosts[0].paths[0].path"=/ \
    --set "ingress.hosts[1].host"=api.devnotnull.com \
    --set "ingress.hosts[1].paths[0].path"=/ \
    devnotnull-api \
    devnotnull/nodejs
```