#!/bin/sh

kubectl delete ingress devnotnull-ui-nodejs

kubectl delete issuer letsencrypt-development
kubectl delete issuer letsencrypt-production

kubectl delete certificate letsencrypt-development
kubectl delete certificate letsencrypt-production

kubectl delete secret letsencrypt-development
kubectl delete secret letsencrypt-production

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
          class:  nginx
EOF

kubectl describe issuer letsencrypt-development
kubectl describe issuer letsencrypt-production

cat <<EOF | kubectl create -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: devnotnull-ui-nodejs
  annotations:
    kubernetes.io/ingress.class: "nginx"    
    cert-manager.io/issuer: "letsencrypt-production"
spec:
  tls:
    - hosts:
        - devnotnull.com
      secretName: letsencrypt-tls-secret
  rules:
    - host: devnotnull.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: devnotnull-ui-nodejs
                port:
                  number: 80

EOF

kubectl get certificate letsencrypt-development
kubectl get certificate letsencrypt-production

kubectl describe secret letsencrypt-development
kubectl describe secret letsencrypt-production
