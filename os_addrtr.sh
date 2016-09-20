#!/bin/bash

neutron router-create ext-rtr
sleep 5
neutron router-interface-add ext-rtr vx-subnet0
neutron router-interface-add ext-rtr vx-subnet1

