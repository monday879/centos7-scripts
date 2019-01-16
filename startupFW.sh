#!/bin/sh -u
PATH=/bin:/usr/bin:/sbin ; export PATH          # (2) PATH line
umask 022                                 # (3) umask line

# Qichen Jia
# This script adds the following firewall rules:
# 1. allows all incoming traffic to the loopback interface.
# 2. allows all incoming traffic from your server interface (source IP).
# 3. block all incoming traffic from your client on port 49999
# 4. allow all incoming traffic of the subnet 172.16.31.0 on port 49999
# 5. blocks all incoming traffic on TCP port 49999.

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -s 172.16.30.44 -j ACCEPT
iptables -I INPUT 3 -s 172.16.31.44 -p tcp --dport 49999 -j REJECT
iptables -I INPUT 4 -s 172.16.31.0/24 -p tcp --dport 49999 -j ACCEPT
iptables -A INPUT -p tcp --dport 49999 -j REJECT
