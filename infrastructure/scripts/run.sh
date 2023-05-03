#!/bin/bash

SSH_KEY=~/.ssh/linode
if [[ ${USER} = 'picounter' ]]; then
	SSH_KEY=~/.ssh/id_ed25519
elif [[ ! -f $SSH_KEY ]]; then
	ssh-keygen -f $SSH_KEY -N ''
	echo 'Please add the following key to your Linode account'
	cat $SSH_KEY
fi
FILE=file2.sh

cd ../ctf_platform/

make down >/dev/null && echo "Tore down surviving VMs"

echo "Starting VM initialiaztion"

terraform apply -auto-approve >/dev/null && echo "Successfully created VMs"
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

echo "Private IP created: $PRIVATE_IP"
ssh-copy-id -i $SSH_KEY root@"$PRIVATE_IP" 
ssh-add $SSH_KEY
scp ../../provisioning/$FILE root@"$PRIVATE_IP":/$FILE 

ssh root@"$PRIVATE_IP" "chmod 775 /$FILE" >/dev/null && echo "Script permissions changed successfully"
ssh root@"$PRIVATE_IP" "/$FILE" >/dev/null && "Successfully instantiated CTF infrastructure"

echo -e "\nYou can now visit your CTF plaform"
echo "http://$PRIVATE_IP:8000"

