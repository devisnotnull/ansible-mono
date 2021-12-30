
## Deploy devnotnull ui

```
helm install fandanzle-v2-api nodejs --set image.repository=alexbrown201/fandanzle-v2-api --set port=3005 --set service.loadBalancerIP=10.150.10.151
```

## Deploy devnotnull api

```
helm install fandanzle-v2 nodejs --set image.repository=alexbrown201/fandanzle-v2 --set port=3005 --set service.loadBalancerIP=10.150.10.134
```