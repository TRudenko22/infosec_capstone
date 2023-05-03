#! /bin/bash
# get file from gh and startup CTFd

# update
apt update >/dev/null
apt upgrade -y >/dev/null
apt install git docker docker-compose -y >/dev/null

cd ${HOME}

#git clone https://github.com/TRudenko22/infosec_capstone.git

# CTFd
git clone https://github.com/CTFd/CTFd.git
cd ${HOME}/CTFd
docker-compose up 

