# HTTP Proxy

Run Nginx as HTTP proxy.

```
# docker run -d --net=host --name=http-proxy chenzhiwei/nginx
```

On client side:

```
# export all_proxy=http://x.x.x.x:3128
```
