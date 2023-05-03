#!/bin/bash

cd ../ctf_platform/

terraform apply -auto-approve >/dev/null
wait $!

terraform output
IP1=$(echo $(terraform output) \
  | awk '{print $5}' \
  | tr -d '"' \
  | tr -d ","  )


IP2=$(echo $(terraform output) \
  | awk '{print $4}' \
  | tr -d '"' \
  | tr -d ","  )

if echo "$IP1" | grep -q "192.168"; then
  PRIVATE_IP="$IP2"
else
  PRIVATE_IP="$IP1"
fi

echo "$PRIVATE_IP"
ssh-copy-id -i ~/.ssh/linode root@"$PRIVATE_IP" 
scp ../scripts/init.sh root@"$PRIVATE_IP":/init.sh 

ssh root@"$PRIVATE_IP" 'chmod 775 /init.sh'
ssh root@"$PRIVATE_IP" '/init.sh'

