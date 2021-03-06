#!/bin/bash
set -e
cat /tmp/puma.service
APP_DIR=${1:-$HOME}
sudo apt-get update
sleep 3
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
