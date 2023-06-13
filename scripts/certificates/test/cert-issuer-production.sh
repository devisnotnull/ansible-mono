#!/bin/sh

kubectl delete issuer letsencrypt-production

kubectl delete certificate letsencrypt-production

kubectl delete secret letsencrypt-production

kubectl delete secret letsencrypt-tls-secret

cat <<EOF | kubectl create -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-production
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: alexbrown201@googlemail.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-production
    # Enable the HTTP-01 challenge provider
    solvers:
    - http01:
        ingress:
          class: nginx
EOF

kubectl describe issuer letsencrypt-production

kubectl get certificate letsencrypt-production

kubectl describe secret letsencrypt-production
