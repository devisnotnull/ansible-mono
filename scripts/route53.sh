#!/bin/sh

AWS_ROUTE53_ZONEID="Z03501612HD7E79ETXM8B"
HOSTNAME="test.devnotnull.com"
TTL="600"
IP=`curl http://ifconfig.co/ 2>/dev/null`

aws route53 change-resource-record-sets --hosted-zone-id $AWS_ROUTE53_ZONEID --change-batch "{ \"Changes\": [ { \"Action\": \"UPSERT\", \"ResourceRecordSet\": { \"Name\": \"$HOSTNAME\", \"Type\": \"A\", \"TTL\": $TTL, \"ResourceRecords\": [ { \"Value\": \"$IP\" } ] } } ] }"
echo "Updated the DNS Zone to $IP"