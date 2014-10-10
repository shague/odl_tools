#!/bin/bash
#fixeth.sh

ipaddr=$1

cp ifcfg-eth0 ifcfg-eth1
cp ifcfg-eth0 ifcfg-eth2

iplink=$(ip link)

for intf in eth0 eth1 eth2; do
    mac=$(ip link | grep -A 1 $intf: | grep link | awk '{print $2}')
    sed -i -e 's/^HWADDR.*$/HWADDR='$mac'/' ifcfg-$intf
    sed -i -e 's/^BOOTPROTO.*$/BOOTPROTO=none/' ifcfg-$intf
    sed -i -e 's/^UUID/#UUID/' ifcfg-$intf
    sed -i -e 's/^ONBOOT.*$/ONBOOT=yes/' ifcfg-$intf
    sed -i -e 's/^NAME.*$/NAME=$intf/' ifcfg-$intf
done

echo "IPADDR=$ipaddr" >> ifcfg-eth2
echo "NETMASK=255.255.255.0" >> ifcfg-eth2
echo "GATEWAY=192.168.120.1" >> ifcfg-eth2
echo "DNS1=192.168.1.1" >> ifcfg-eth2
