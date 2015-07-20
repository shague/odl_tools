#!/bin/bash

neutron net-create ext-net --router:external --provider:physical_network public --provider:network_type flat

neutron subnet-create --name ext-subnet --allocation-pool start=192.168.56.9,end=192.168.56.14 --disable-dhcp --gateway 192.168.56.1 ext-net 192.168.56.0/24
sleep 5
neutron router-create ext-rtr
neutron router-gateway-set ext-rtr ext-net

neutron net-create vx-net --provider:network_type vxlan --provider:segmentation_id 1500
neutron subnet-create vx-net 10.100.5.0/24 --name vx-subnet --dns-nameserver 8.8.8.8
sleep 5
neutron router-interface-add ext-rtr vx-subnet
