#! /bin/bash
# run CTFd inside docker container

# update
apt update -y && echo -e "\nPackages updated\n"
apt upgrade  -y && echo -e "\nPackages upgraded\n"
apt install git docker docker-compose -y 

cd ${HOME}

# CTFd
git clone https://github.com/CTFd/CTFd.git
cd ${HOME}/CTFd
docker-compose up -d

echo "Docker compose initiated"

