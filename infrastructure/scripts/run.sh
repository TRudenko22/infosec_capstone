#!/bin/bash

SSH_KEY=~/.ssh/linode
FILE=file2.sh

if [[ ${USER} = 'picounter' ]]; then
	SSH_KEY=~/.ssh/id_ed25519
elif [[ ! -f $SSH_KEY ]]; then
	echo 'Default ~/.ssh/linode ssh key not found.'
	echo 'Enter path for your Linode ssh key or press enter to create a new key: '
	read RESPONSE
	if [ $RESPONSE = '' ]; then
		ssh-keygen -f $SSH_KEY -N ''
		echo 'Please add the following key to your Linode account'
		cat $SSH_KEY
  		exit 0
	else
		SSH_KEY=$RESPONSE
	fi
	echo $RESPONSE
fi

cd ../ctf_platform/

make down >/dev/null && echo "Tore down surviving VMs"

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

