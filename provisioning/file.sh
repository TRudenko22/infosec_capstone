#! /bin/bash
# run CTFd with flask

# update
apt update
apt upgrade -y
apt install git python3-pip python3-flask -y

pip3 install flask

cd ${HOME}

#git clone https://github.com/TRudenko22/infosec_capstone.git

# CTFd
git clone https://github.com/CTFd/CTFd.git
cd ${HOME}/CTFd
#./prepare.sh
pip install -r requirements.txt
flask run &
while ! curl -s http://localhost:4000/ > /dev/null; do
	sleep 1
done
echo 'Flask is up and running'

