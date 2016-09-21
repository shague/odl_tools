#!/bin/bash

neutron router-create ext-rtr
neutron net-create vx-net --provider:network_type vxlan --provider:segmentation_id 1500
neutron subnet-create vx-net 10.100.5.0/24 --name vx-subnet
sleep 5
neutron router-interface-add ext-rtr vx-subnet
