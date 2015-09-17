#!/usr/bin/env bash

in_interface=wlan1
out_interface=wlan0

http_port=80
https_port=443
destination_host=127.0.0.1
destination_port=8080

# reset all iptables rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

ifconfig $in_interface 10.0.0.1 netmask 255.255.255.0

# enable ip forwarding and ip forwarding to localhost
sysctl -w net.ipv4.ip_forward=1
sysctl  -w net.ipv4.conf."$in_interface".route_localnet=1
sysctl -p

# forward all other wlan1 traffic through wlan0
iptables -t nat -A POSTROUTING --out-interface $out_interface -j MASQUERADE  
iptables -A FORWARD --in-interface $in_interface -j ACCEPT


# port forward to mitmproxy
iptables -t nat -A PREROUTING -p tcp -i $in_interface --dport $http_port -j DNAT --to-destination $destination_host:$destination_port

iptables -t nat -A PREROUTING -p tcp -i $in_interface --dport $https_port -j DNAT --to-destination $destination_host:$destination_port

iptables -A FORWARD -p tcp -d $destination_host --dport $destination_port -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT




