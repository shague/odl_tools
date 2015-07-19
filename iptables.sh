sudo iptables -I INPUT -p tcp -m multiport --dports 80,443,139,445 -j ACCEPT
sudo iptables -I INPUT -p udp -m multiport --dports 137,138 -j ACCEPT
sudo iptables -I INPUT -p tcp -m multiport --dports 5000,5672,6080,8774,9292,9696,35357 -j ACCEPT

