#!/bin/bash
#fixeth2.sh
                                                                                                                                                                                                           
usage="usage: 0 hostname ipaddr {netmask:-255.255.255.0} {gateway:-192.168.120.1} {dns1:-192.168.1.1}"                                                                                                     
hostname=${1:?"$usage: hostname must be set"}                                                                                                                                                              
ipaddr=${2:?"$usage: ipaddr must be set"}                                                                                                                                                                  
netmask=${3:-255.255.255.0}                                                                                                                                                                                
gateway=${4:-192.168.120.1}                                                                                                                                                                                
dns1=${5:-192.168.1.1}                                                                                                                                                                                     
                                                                                                                                                                                                           
hostnamectl set-hostname $hostname                                                                                                                                                                         
                                                                                                                                                                                                           
iplink=$(ip link)                                                                                                                                                                                          
                                                                                                                                                                                                           
for intf in eth0 eth1 eth2; do                                                                                                                                                                             
    mac=$(ip link | grep -A 1 $intf: | grep link | awk '{print $2}')                                                                                                                                       
    sed -i -e 's/^HWADDR.*$/HWADDR='$mac'/' ifcfg-$intf                                                                                                                                                    
    sed -i -e 's/^BOOTPROTO.*$/BOOTPROTO=none/' ifcfg-$intf                                                                                                                                                
    sed -i -e 's/^UUID/#UUID/' ifcfg-$intf                                                                                                                                                                 
    sed -i -e 's/^ONBOOT.*$/ONBOOT=yes/' ifcfg-$intf                                                                                                                                                       
    sed -i -e 's/^NAME.*$/NAME='$intf'/' ifcfg-$intf                                                                                                                                                       
done                                                                                                                                                                                                       
                                                                                                                                                                                                           
sed -i -e 's/^IPADDR.*$/IPADDR='$ipaddr'/' ifcfg-eth2                                                                                                                                                      
sed -i -e 's/^NETMASK.*$/NETMASK='$netmask'/' ifcfg-eth2                                                                                                                                                   
sed -i -e 's/^GATEWAY.*$/GATEWAY='$gateway'/' ifcfg-eth2                                                                                                                                                   
sed -i -e 's/^DNS1.*$/DNS1='$dns1'/' ifcfg-eth2                                                                                                                                                            
                                                                                                                                                                                                           
systemctl restart network                                                                                                                                                                                  
                                                                                                                                                                                                           
echo "modify the host entries in /etc/hosts"
