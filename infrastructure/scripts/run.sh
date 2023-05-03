#!/bin/bash

SSH_KEY=''
FILE=file2.sh

cd ../ctf_platform/

make down >/dev/null && echo "Tore down surviving VMs"
SSH_KEY=$(ssh-keygen -f ~/.ssh/linode.GhJHjhlk -N)

echo "Starting VM initialiaztion"

terraform apply -auto-approve && echo -e "\nSuccessfully created VMs"
wait $!

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

echo "Private IP created: $PRIVATE_IP"
ssh-copy-id -i $SSH_KEY root@"$PRIVATE_IP" 
ssh-add $SSH_KEY
scp ../../provisioning/$FILE root@"$PRIVATE_IP":/$FILE 

ssh root@"$PRIVATE_IP" "chmod 775 /$FILE" && echo "Script permissions changed successfully"
ssh root@"$PRIVATE_IP" "/$FILE" && echo "Successfully instantiated CTF infrastructure"

echo -e "\nYou can now visit your CTF plaform"
echo "http://$PRIVATE_IP:8000"

