#! /bin/bash
# get file from gh and startup CTFd

# update
apt update -qqq -y && echo "Packages updated"
apt upgrade -qqq  -y && echo "Packages upgraded"
apt install git docker docker-compose -y && echo "Tools installed"

cd ${HOME}

#git clone https://github.com/TRudenko22/infosec_capstone.git

# CTFd
git clone https://github.com/CTFd/CTFd.git
cd ${HOME}/CTFd
docker-compose up &

echo "Docker compose initiated"

