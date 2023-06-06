#!/bin/sh

curl https://packages.grafana.com/gpg.key | sudo apt-key add -
apt install -y apt-transport-https
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
apt -y update && sudo apt -y install grafana
systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server.service
systemctl status grafana-server