#!/bin/bash
# Stops, cleans and restarts openvswitch and logs captured.

sudo systemctl stop openvswitch
sudo rm -rf /var/log/openvswitch/*
sudo rm -rf /etc/openvswitch/conf.db
sudo systemctl start openvswitch
/opt/tools/setlog.sh

rm -rf /opt/logs/stack/*

#sudo ovs-vsctl add-br br-eth1
#sudo ovs-vsctl add-port br-eth1 eth1
#sudo ovs-vsctl add-br br-eth3
#sudo ovs-vsctl add-port br-eth3 eth3
