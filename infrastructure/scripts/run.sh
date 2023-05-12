#!/bin/bash

# Constancts
FILE=file2.sh
SSH_KEY=~/.ssh/linode
PASSWORD_FILE=../ctf_platform/variables.tf 
DEPENDENCIES_FILE="dependencies.txt"

# Variables
CHANGED_PASSWORD=false

# Functions
function prepare_terraform {
	echo 'Adding Terraform repository...'
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
	sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
	echo 'Updating package lists...'
	sudo apt update
}

function verify_dependencies {
	while read dependency; do
		if ! dpkg -s "$dependency" > /dev/null 2>&1 ; then
			if [ $dependency = 'terraform' ]; then
				prepare_terraform
			fi
			echo "$dependency is not installed. Installing..."
			if ! sudo apt install -y "$dependency"; then
				echo "! ERROR installing $dependency"
				exit 1
			fi
		else
			echo "$dependency is already installed."
		fi
	done < "$DEPENDENCIES_FILE"
}

function generate_random_password {
	CHANGED_PASSWORD=true
	# generate 12 char long password with upper, lower, numbers, and special
	password=$(apg -n 1 -m 12 -M SNCL)
	# backup file
	if ! [ -f ${PASSWORD_FILE}.bkup ]; then
		cp $PASSWORD_FILE ${PASSWORD_FILE}.bkup
	fi
	sed -i "s/pleasechangethepassword/${password}/" $PASSWORD_FILE
	echo -e "~ Your one time password for this instance is: ${password}"
}

verify_dependencies 

cd ../ctf_platform/

# Tear down VM
echo "Tearing down any existing CTF instances"
make down >/dev/null && echo "Tore down surviving VMs"
echo -e "Starting VM initialization\n"

# Create VM
output=$(terraform apply -auto-approve 2>&1)
if [ $? -ne 0 ]; then
	echo -e "\n ! ERROR creating VMs"
	echo "~ Did you remember to add your API key to infosec_capstone/infrastructure/ctf_platform/variables.tf ? ~"
	exit 1
else
	echo -e "\nSuccessfully created VMs"
fi

# Get IP address of new instance
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

# Create Linode VM SSH key if one doesn't exist
if [ ! -f $SSH_KEY ]; then
	echo 'Generating Linode Key Pair'
	ssh-keygen -t rsa -f $SSH_KEY -N ''
fi
eval $(ssh-agent -s)
ssh-add $SSH_KEY

#generate_random_password 

# Copy SSH key to new VM (Password required from infosec_capstone/infrastructure/ctf_platform/variables.tf)
ssh-copy-id -i $SSH_KEY root@"$PRIVATE_IP" 

# Copy VM configuration file to new VM
scp ../../provisioning/$FILE root@"$PRIVATE_IP":/$FILE 

# Execute configuration file on new VM
ssh root@"$PRIVATE_IP" "chmod 775 /$FILE" && echo "Script permissions changed successfully"
ssh root@"$PRIVATE_IP" "/$FILE" && echo "Successfully instantiated CTF infrastructure"

# wait for website to be up
while ! curl -s $PRIVATE_IP:8000 > /dev/null; do
	sleep 1
done
echo -e "\nYou can now visit your CTF plaform"
echo "http://$PRIVATE_IP:8000"

if [ $CHANGED_PASSWORD = 'true' ]; then
	cp ${PASSWORD_FILE}.bkup $PASSWORD_FILE
	rm ${PASSWORD_FILE}.bkup
fi

