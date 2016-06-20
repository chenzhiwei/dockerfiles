# Socket proxy

```
# docker run -d --restart=always --net=host --name=socket-proxy chenzhiwei/shadowsocks
# docker run -d --restart=always --net=host --name=socket-proxy chenzhiwei/shadowsocks --workers 2 -p 443 -k password
# docker run -d --restart=always --net=host --name=socket-proxy -v /path/to/shadowsocks.json:/etc/shadowsocks.json chenzhiwei/shadowsocks
```
