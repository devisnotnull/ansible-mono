#!/bin/sh

kubectl delete issuer letsencrypt-development

kubectl delete certificate letsencrypt-development

kubectl delete secret letsencrypt-development

kubectl delete secret letsencrypt-tls-secret

: '
cat <<EOF | kubectl create -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-development
spec:
  acme:
    # The ACME server URL
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: alexbrown201@googlemail.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-development
    # Enable the HTTP-01 challenge provider
    solvers:
    - http01:
        ingress:
          class:  nginx
EOF
'

kubectl describe issuer letsencrypt-development

kubectl get certificate letsencrypt-development

kubectl describe secret letsencrypt-development
