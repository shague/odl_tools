#!/bin/bash

nova boot --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net | awk '{print $2}') vmvx1 --availability_zone=nova:odl31
sleep 3
nova boot --flavor m1.nano --image $(nova image-list | grep 'uec\s' | awk '{print $2}' | tail -1) --nic net-id=$(neutron net-list | grep -w vx-net | awk '{print $2}') vmvx2 --availability_zone=nova:odl32
sleep 3
nova get-vnc-console vmvx1 novnc
nova get-vnc-console vmvx2 novnc
