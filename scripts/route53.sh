#!/bin/sh

AWS_ROUTE53_ZONEID="Z03501612HD7E79ETXM8B"
HOSTNAME="api.devnotnull.com"
TTL="600"
IP="86.9.171.110"

aws route53 change-resource-record-sets --hosted-zone-id $AWS_ROUTE53_ZONEID --change-batch "{ \"Changes\": [ { \"Action\": \"UPSERT\", \"ResourceRecordSet\": { \"Name\": \"$HOSTNAME\", \"Type\": \"A\", \"TTL\": $TTL, \"ResourceRecords\": [ { \"Value\": \"$IP\" } ] } } ] }"
echo "Updated the DNS Zone to $IP"