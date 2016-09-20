#!/bin/bash

neutron net-create vx-net1 --provider:network_type vxlan --provider:segmentation_id 1501
neutron subnet-create vx-net1 10.100.6.0/24 --name vx-subnet1 --dns-nameserver 8.8.8.8

