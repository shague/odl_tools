#!/bin/bash

source openrc admin admin

/opt/tools/os_addnano.sh
sleep 1
/opt/tools/os_addadminkey.sh
sleep 1
/opt/tools/os_addnet0.sh
sleep 5
/opt/tools/os_addvms0.sh
sleep 5
/opt/tools/os_addnet1.sh
sleep 5
/opt/tools/os_addvms1.sh
sleep 5
/opt/tools/os_addrtr.sh
sleep 5
/opt/tools/os_addextnet.sh
sleep 5
/opt/tools/os_addfloatingips.sh
#sleep 1
#/opt/tools/os_addsecuritygroups.sh
