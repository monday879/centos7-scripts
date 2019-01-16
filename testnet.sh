#!/bin/sh -u
PATH=/bin:/usr/bin:/sbin ; export PATH          # (2) PATH line
umask 022                                 # (3) umask line

# This script summarizes network settings and outputs the results.
# Date: 2019, Jan 9
# Student Name: Qichen Jia
# Student Number: 040914732

echo
echo 'Network Settings'
echo '================'

echo 
echo 'Network Services Status'
echo '-----------------------'
echo "NetworkManager: `systemctl status NetworkManager | grep 'Active'`"
echo "Network:        `systemctl status network | grep 'Active'`"
echo "Firewalld:      `systemctl status firewalld | grep 'Active'`"
echo "iptables:          `systemctl list-units --all | grep iptables | awk '{print $4}'`"
echo "SELinux status:    `sestatus | grep 'SELinux status:' | awk '{print $3}'`"
echo

echo "Network Settings"
echo "----------------"
echo "Blue network interface IP address:  ens33 `ip addr show ens33 | egrep -o '([[:digit:]]{1,3}.){3}[[:digit:]]{1,3}/[[:digit:]]{1,2}'`"
echo "Red  network interface IP address:  ens34 `ip addr show ens34 | egrep -o '([[:digit:]]{1,3}.){3}[[:digit:]]{1,3}/[[:digit:]]{1,2}'`"
echo "Default gateway:                    `ip route | grep 'default'`"
echo "Order of hostname resolution:       `cat /etc/nsswitch.conf | grep '^hosts'`"
echo
echo "DNS servers:"
echo "`cat /etc/resolv.conf`"
echo
echo "Host file contents:"
echo "`cat /etc/hosts`"
echo


PingTest () {
ping -c 4 $IPforTest > /dev/null 2>&1
if [ $? -eq 0 ]; then
   echo "success"
else
   echo "failed"
fi
}

echo "Ping Results"
echo "------------"

IPforTest="172.16.31.44"
echo "Between your server and your client (red network):"
echo "To client: `PingTest`"

IPforTest="172.16.30.44"
echo "To server: `PingTest`"
echo

IPforTest="172.16.30.108"
echo "Between your server and lab partner's server (red network): `PingTest`"

IPforTest="192.168.136.2"
echo "Between your server and the default gateway (blue network): `PingTest`"
echo
