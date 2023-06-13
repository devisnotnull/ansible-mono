#!/bin/sh

AWS_ACCESS_KEY_ID=AKIAULF66LSWFJPSKBJC
AWS_SECRET_ACCESS_KEY=
echo ${AWS_SECRET_ACCESS_KEY} > password.txt

kubectl create secret generic aws-route53-creds --from-file=password.txt -n cert-manager
rm -f password.txt

cat <<EOF | kubectl create -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt
  namespace: cert-manager
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: alexbrown201@googlmail.com
    privateKeySecretRef:
      name: letsencrypt-staging
    
    solvers:
    - selector:
        dnsZones:
          - "devnotnull.com"
      dns01:
        route53:
          region: eu-central-1
          accessKeyID: $AWS_ACCESS_KEY_ID
          secretAccessKeySecretRef:
            name: aws-route53-creds
            key: password.txt
EOF

cat <<EOF | kubectl create -f -
apiVersion: certmanager.k8s.io/v1
kind: Certificate
metadata:
  name: wildcard-cert
  namespace: cert-manager
spec:
  secretName: wildcard-cert-tls
  issuerRef:
    name: letsencrypt
    kind: ClusterIssuer
  commonName: '*.devnotnull.com'
  dnsNames:
    - '*.devnotnull.com'
  acme:
    config:
    - dns01:
        provider: route53
      domains:
      - '*.devnotnull.com'
EOF