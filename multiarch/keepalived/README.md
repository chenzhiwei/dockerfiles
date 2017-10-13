docker run -d --net=host --cap-add NET_ADMIN -e VIP=10.0.0.10/24 -e INTERFACE=eth0 siji/keepalived:1.2.24
