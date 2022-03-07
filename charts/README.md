
## Deploy devnotnull ui

```
helm install fandanzle-v2-api nodejs \
--set image.repository=alexbrown201/fandanzle-v2:stable \
--set port=3000 \
--set mongo.enabled=false \
--set service.type=LoadBalancer \
--set service.loadBalancerIP=10.150.10.134 \
--set image.pullPolicy=Always

```

## Deploy devnotnull api

```
helm install fandanzle-v2 nodejs \
--set image.repository=alexbrown201/fandanzle-v2:stable \
--set port=3000 \
--set mongo.enabled=false \
--set service.type=LoadBalancer \
--set service.loadBalancerIP=10.150.10.134 \
--set image.pullPolicy=Always

```