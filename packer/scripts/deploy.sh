#!/bin/sh
cd ~
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
mv /home/ubuntu/reddit.service /etc/systemd/system/reddit.service
chmod a+x /home/ubuntu/reddit-start.sh
systemctl start reddit
systemctl enable reddit
