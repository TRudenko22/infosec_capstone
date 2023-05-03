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
scp ../../provisioning/file.sh root@"$PRIVATE_IP":/file.sh 

ssh root@"$PRIVATE_IP" 'chmod 775 /file.sh'
ssh root@"$PRIVATE_IP" '/file.sh'

