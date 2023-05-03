#! /bin/bash
# get file from gh and startup CTFd

# update
apt update
apt upgrade -y
apt install git docker docker-compose -y

cd ${HOME}

#git clone https://github.com/TRudenko22/infosec_capstone.git

# CTFd
git clone https://github.com/CTFd/CTFd.git
cd ${HOME}/CTFd
docker-compose up

