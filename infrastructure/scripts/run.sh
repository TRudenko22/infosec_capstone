#!/bin/bash


SSH_KEY=~/.ssh/linode
FILE=file2.sh

cd ../ctf_platform/

make down
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
ssh-copy-id -i $SSH_KEY root@"$PRIVATE_IP" 
scp ../../provisioning/$FILE root@"$PRIVATE_IP":/$FILE 

ssh root@"$PRIVATE_IP" 'chmod 775 /$FILE
ssh root@"$PRIVATE_IP" '/$FILE

