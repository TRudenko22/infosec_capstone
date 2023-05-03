#! /bin/bash
# get file from gh and startup CTFd

# update
apt update -y && echo -e "\nPackages updated\n"
apt upgrade  -y && echo "\nPackages upgraded\n"
apt install git docker docker-compose -y 

cd ${HOME}

#git clone https://github.com/TRudenko22/infosec_capstone.git

# CTFd
git clone https://github.com/CTFd/CTFd.git
cd ${HOME}/CTFd
docker-compose up

echo "Docker compose initiated"

