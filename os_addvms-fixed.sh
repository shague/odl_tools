#!/bin/bash

nova boot --poll --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net | awk '{print $2}'),v4-fixed-ip=10.100.5.3 vmvx1 --availability-zone=nova:odl31 --key-name admin_key
sleep 5
nova boot --poll --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net | awk '{print $2}'),v4-fixed-ip=10.100.5.4 vmvx2 --availability-zone=nova:odl32 --key-name admin_key
sleep 5
nova get-vnc-console vmvx1 novnc
nova get-vnc-console vmvx2 novnc
