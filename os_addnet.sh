#!/bin/bash

neutron net-create vx-net --provider:network_type vxlan --provider:segmentation_id 1500
sleep 5
neutron subnet-create vx-net 10.100.5.0/24 --name vx-subnet
