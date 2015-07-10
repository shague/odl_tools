#!/bin/bash
#fixeth2.sh - run as root or sudo

usage="usage: $0 hostname eth0ipaddr eth1ipaddr {netmask:-255.255.255.0} {gateway:-192.168.120.1} {dns1:-192.168.1.1}"
hostname=${1:?"$usage: hostname must be set"}
eth0ipaddr=${2:?"$usage: eth0ipaddr must be set"}
eth1ipaddr=${3:?"$usage: eth1ipaddr must be set"}
netmask=${4:-255.255.255.0}
gateway=${5:-192.168.120.1}
dns1=${6:-192.168.1.1}
ip -4 addr
hostnamectl set-hostname $hostname
cwd=$(pwd)
cd /etc/sysconfig/network-scripts

for intf in eth0 eth1 eth2; do
    cp ifcfg-$intf ifcfg-$intf.bak
    mac=$(ip link show | grep -A 1 $intf: | grep link | awk '{print $2}')
    # Add lines that are not currently in the file
    grep -q -F 'HWADDR' ifcfg-$intf || echo 'HWADDR' >> ifcfg-$intf
    grep -q -F 'BOOTPROTO' ifcfg-$intf || echo 'BOOTPROTO' >> ifcfg-$intf
    grep -q -F 'UUID' ifcfg-$intf || echo 'UUID' >> ifcfg-$intf
    grep -q -F 'ONBOOT' ifcfg-$intf || echo 'ONBOOT' >> ifcfg-$intf
    grep -q -F 'NAME' ifcfg-$intf || echo 'NAME' >> ifcfg-$intf

    sed -i -e 's/^HWADDR.*$/HWADDR='$mac'/' ifcfg-$intf
    sed -i -e 's/^BOOTPROTO.*$/BOOTPROTO=none/' ifcfg-$intf
    sed -i -e 's/^UUID/#UUID/' ifcfg-$intf
    sed -i -e 's/^ONBOOT.*$/ONBOOT=yes/' ifcfg-$intf
    sed -i -e 's/^NAME.*$/NAME='$intf'/' ifcfg-$intf
done

grep -q -F 'IPADDR' ifcfg-eth0 || echo 'IPADDR' >> ifcfg-eth0
grep -q -F 'NETMASK' ifcfg-eth0 || echo 'NETMASK' >> ifcfg-eth0
grep -q -F 'GATEWAY' ifcfg-eth0 || echo 'GATEWAY' >> ifcfg-eth0
grep -q -F 'DNS1' ifcfg-eth0 || echo 'DNS1' >> ifcfg-eth0

sed -i -e 's/^IPADDR.*$/IPADDR='$eth0ipaddr'/' ifcfg-eth0
sed -i -e 's/^NETMASK.*$/NETMASK='$netmask'/' ifcfg-eth0
sed -i -e 's/^GATEWAY.*$/GATEWAY='$gateway'/' ifcfg-eth0
sed -i -e 's/^DNS1.*$/DNS1='$dns1'/' ifcfg-eth0

grep -q -F 'IPADDR' ifcfg-eth1 || echo 'IPADDR' >> ifcfg-eth1
grep -q -F 'PREFIX' ifcfg-eth1 || echo 'PREFIX' >> ifcfg-eth1
sed -i -e 's/^IPADDR.*$/IPADDR='$eth1ipaddr'/' ifcfg-eth1
sed -i -e 's/^PREFIX.*$/PREFIX="24"/' ifcfg-eth1

systemctl restart network

echo "modify the host entries in /etc/hosts"

cd $cwd
