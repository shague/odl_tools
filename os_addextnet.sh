#!/bin/bash

#
# Make sure you've created ext-rtr before running this script.
#

neutron net-create ext-net --router:external --provider:physical_network public --provider:network_type flat

neutron subnet-create --name ext-subnet --allocation-pool start=192.168.56.9,end=192.168.56.14 --disable-dhcp --gateway 192.168.56.1 ext-net 192.168.56.0/24
sleep 5
neutron router-gateway-set ext-rtr ext-net

