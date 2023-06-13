ipmitool lan set 1 ipsrc static

ipmitool lan set 1 ipaddr 1O.10.10.40

ipmitool lan set 1 netmask 255.255.255.0 

ipmitool lan set 1 defgw ipaddr 10.10.10.1

ipmitool lan set 1 arp respond on

ipmitool lan set 1 auth ADMIN MD2,MD5,PASSWORD

ipmitool lan set 1 access on