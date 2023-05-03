#!/bin/bash

cd ../ctf_platform/

terraform apply -auto-approve
wait $!

echo $(terraform output)


#ssh-copy-id -i ~/.ssh/linode

