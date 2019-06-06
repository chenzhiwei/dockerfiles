# Polipo

Run as HTTP Proxy:

```
# docker run -d --name=http-proxy -p 8123:8123 chenzhiwei/polipo
```

Change the Socks Proxy to HTTP Proxy:

```
# docker run -d --name=http-proxy --net=host chenzhiwei/polipo proxyAddress=0.0.0.0 socksParentProxy=127.0.0.1:1080 socksProxyType=socks5
```
