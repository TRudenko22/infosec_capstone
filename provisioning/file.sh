#! /bin/bash
# get file from gh and startup CTFd

# update
apt update
apt upgrade -y
apt install git python3-pip python3-flask -y

cd ${HOME}

#git clone https://github.com/TRudenko22/infosec_capstone.git

# CTFd
git clone https://github.com/CTFd/CTFd.git
cd ${HOME}/CTFd
#./prepare.sh
pip install -r requirements.txt
flask run

