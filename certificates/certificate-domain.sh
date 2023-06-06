#!/bin/sh

# This script will create a certificate for a subdomain
# ./certificate-sub-domain.sh staging 149.86.35.190 devnotnull.com
# ./certificate-sub-domain.sh staging 149.86.35.190 devnotnull.com vpn

staging="https://acme-staging-v02.api.letsencrypt.org/directory"
production="https://acme-v02.api.letsencrypt.org/directory"

echo $staging
echo $production

if [ $1 == "staging" ]
then
  domain=$staging
else
  domain=$production
fi

if [ -z $4 ]
then 
  fulldomain=$3
  fulldomainString=$3
else
  fulldomain=$4.$3
  fulldomainString=$4-$3
fi

echo "full domain is $fulldomain"

echo "We will be creating the following certificate $domain"

echo "Curate R53 config for $fulldomain"

recordSet=$(cat <<EOF
{
  "Comment": "A new record set for the zone.",
  "Changes": [
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "$fulldomain.",
        "Type": "A",
        "TTL": 600,
        "ResourceRecords": [
          {
            "Value": "$2"
          }
        ]
      }
    }
  ]
}
EOF
)

cat <<< $recordSet > r53-staging-request.json

echo "Generate a certificate for $fulldomain"

aws route53 change-resource-record-sets --hosted-zone-id Z03501612HD7E79ETXM8B --change-batch file://r53-staging-request.json

echo "Generate certificate issuer for $fulldomain"

cat <<EOF | kubectl create -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-$1-issuer
  namespace: default
spec:
  acme:
    # The ACME server URL
    server: $domain
    # Email address used for ACME registration
    email: alexbrown201@googlemail.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-$1-issuer
    # Enable the HTTP-01 challenge provider
    solvers:
    - http01:
        ingress:
          class: nginx
EOF

echo "Generate certificate for $fulldomain"

cat <<EOF | kubectl create -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: $fulldomainString-$1
  namespace: default
spec:
  secretName: $fulldomainString-$1
  issuerRef:
    name: letsencrypt-$1-issuer
  commonName: $fulldomain
  dnsNames:
  - $fulldomain
EOF
